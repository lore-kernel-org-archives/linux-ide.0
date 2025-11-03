Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407F22A4FE
	for <linux-ide@vger.kernel.org>; Mon,  3 Nov 2025 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762143740; cv=none; b=jlWOsZcENEQStbZ8LnXya3Z4agNPleqqXmFPFPEm/cvwWFZxWOrEMECMl9hDEmUrolGdqKb6ecuAF+jWYRP88opX1Ax4b32ywim9qa8NxX9PTuxfB/aCTHgqjTckBBJkiODN194Fi9HwPZFUQiInKO5HEsIQDMBrbLc3z88q8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762143740; c=relaxed/simple;
	bh=37k5+lPOwMHFstdVADHFxqulEPDlrNzPNfXWkPyYvlY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VwE3Cky50CXTuwbsTed7h3CDsbYobaGob1wErOLZtwLMGfZf3ARUG/Q+6Q5pOJPalQFwgLAiL4fyQIQVMPnxQFRGjduZiMWqobDVEyiX3Td5JsQ6DMmWuNliT2K5uZgdCQJ1d/K6e3cI3CGaKu3My7q+cl0hQGbCwBy5/tUysL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.15.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4d0J9c5N6Fz8txy
	for <linux-ide@vger.kernel.org>; Mon,  3 Nov 2025 15:13:39 +1100 (AEDT)
Message-ID: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
Date: Mon, 3 Nov 2025 15:13:34 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Content-Language: en-US
To: list linux-ide <linux-ide@vger.kernel.org>
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: ata timeout exceptions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have a sata disk that is probably on its last legs.
It is a plain disk (no RAID or such). If it matters, it is an old 8TB Seagate SMA disk.
It sees very little activity.

Every two hours a small rsync copies a directory into this disk. A few 100s of files are copied each time, a few 10s of GB in total.

For the last few weeks it started to log timeout errors (not always) like this:

   kernel: ata2.00: exception Emask 0x0 SAct 0x2020 SErr 0x0 action 0x6 frozen
   kernel: ata2.00: failed command: WRITE FPDMA QUEUED
   kernel: ata2.00: cmd 61/80:28:a0:10:df/00:00:d1:01:00/40 tag 5 ncq dma 65536 out
                    res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
   kernel: ata2.00: status: { DRDY }
   kernel: ata2.00: failed command: WRITE FPDMA QUEUED
   kernel: ata2.00: cmd 61/00:68:18:15:30/20:00:20:01:00/40 tag 13 ncq dma 4194304 out
                    res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
   kernel: ata2.00: status: { DRDY }
   kernel: ata2: hard resetting link
   kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
   kernel: ata2.00: configured for UDMA/133
   kernel: ata2: EH complete

Looking at the smart log I see that one more command_timeout was counted and no other attribute is incremented.

However, later on, this error was followed by 31 more failures, probably the full command queue was aborted.
The messages mention 'tag 0 ncq dma' through 'tag 31 ncq dma'.
Again, in the smart log, the whole burst counted as one extra command_timeout.

After this going on for a few days, a repeated burst of errors lead to:
   kernel: ata2.00: NCQ disabled due to excessive errors

 From now on, only one exception is logged:
   kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
   kernel: ata2.00: failed command: WRITE DMA EXT
   kernel: ata2.00: cmd 35/00:00:98:a3:4c/00:20:86:01:00/e0 tag 6 dma 4194304 out
                    res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
   kernel: ata2.00: status: { DRDY }
   kernel: ata2: hard resetting link
   kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
   kernel: ata2.00: configured for UDMA/133
   kernel: ata2: EH complete

Furthermore, the smart log shows no change. This has been going on for the last two days,
over a dozen times.

I want to understand what is going on:

1) Why do I not see an I/O error and the writes to the disk (rsync) seem to complete?
    Which layer absorbs the errors, hiding them from the application?

2) Why do I get only one command_timeout counted (originally, with ncq active) and none when ncq is disabled?

Naturally, I already copied the disk to a replacement which I will install after this disk fails completely.

--
Eyal at Home (eyal@eyal.emu.id.au)

