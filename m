Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3B1FF1C7
	for <linux-ide@vger.kernel.org>; Sat, 10 Jan 2026 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005800; cv=none; b=ilaeKy5JEGrHbLhwpUhaeggnXQCPO8GFCUe2yhtoJxJGlfRS4DSekhI2iMZVo+TP9zzco8YK7Fx56Gs7RWo67MoB3zTb6+yUQrmnJ35CpVDDIfXqx+oLW2Z4hJCzlrr62EgE9oArXj9amG/gBm595UFIUiDQve6qmKxg0QL6E6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005800; c=relaxed/simple;
	bh=7WqiBdQSQAlrQYU4KCjgNxHtTN3uDaG0vQRN50m53bg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aAdOwr7QfJm4moZIfhTc+fY/dbbYv/+NfUqokQH/ekcDmJzt2Vcrynv51wvv8zi3ExAkJVLqUWcOYZrLUAMNP7jMtiBpKCTrvPzsI9kf98WFxOutFc4jeHkNvPnMMCosy9KQ4WrVVfN121+Sd+LAWqN/EG6PhC89dUyaWltrGKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dp07B1SByz8trQ
	for <linux-ide@vger.kernel.org>; Sat, 10 Jan 2026 11:36:06 +1100 (AEDT)
Message-ID: <a41dafec-2ab8-4e6f-83f6-628104ee9b7b@eyal.emu.id.au>
Date: Sat, 10 Jan 2026 11:35:57 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: list linux-ide <linux-ide@vger.kernel.org>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Why do Pending sectors disappear without writing to them?
Reply-To: "Eyal Lebedinsky (emu)" <eyal@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This happens with some regularity. This disk (/dev/sdf1) is part of a raid6. It seems to be unhealthy (another story).
What I saw, a few times recently, is a smart report like
	197 Current_Pending_Sector  -O--C-   100   100   000    -    8
	198 Offline_Uncorrectable   ----C-   100   100   000    -    8
and at the end of the smart report
	Pending Defects log (GP Log 0x0c)
	Index                LBA    Hours
	    0        22791960168    54593
	    1        22791960169    54593
	    2        22791960170    54593
	    3        22791960171    54593
	    4        22791960172    54593
	    5        22791960173    54593
	    6        22791960174    54593
	    7        22791960175    54593
This stays for some time. For example this morning it started just after midnight
until I checked the logs this morning.

I reacted by running
	$ sudo raid6check /dev/md127 $(((22791960168-2048-262144)/1024-1)) 2
BTW, I convert sector number to fs block:
	2048   (sdf1 start from fdisk)
	262144 'Data Offset : 262144 sectors' from 'mdadm --examine'
	1024   'Chunk Size : 512K' [1024s]    from 'mdadm --examine'
I expected an issue to be reported, but none were.
However ... the above 197/198 smart attributes went to zero, and the 'Pending Defects log' was cleared.

My question is: raid6check is running in read-only mode, yet the disk cleared the pending reports. Why?
I thought that you need to write to it for that.

Maybe the disk attempts to read the block (8 sectors) anyway and decides it is actually good?
	In other words: first read failure is logged as Pending, a following good read clears it?
	A failed write counts it as Reallocated_Sector_Ct.

Interestingly, there is no indication of the reason for the initial failure (197/198 0->8).
No i/o error. No md report. No program failure.
The first log is from a regular 30m smart check.

TIA

-- 
Eyal at Home (eyal@eyal.emu.id.au)

