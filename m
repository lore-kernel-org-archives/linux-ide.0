Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B312EBEA
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422541; cv=none; b=WtGq00riHeNpNKz22aanBs7/ayVad59LcVJjeXQmxkJsuWa4vToXL+4S1Wjvct2ABaUqbdkT7GP9v4Xoaof3EltaRk9MaGQO6PojOJf+/TYN2sR+DsElG5i9MOOjJPJXGeVJYNkJQHEb29+N4rzZsBNPk6niAGOI+nx28+ioOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422541; c=relaxed/simple;
	bh=ih1Twwiqmt87sULjoF0o1mtEI05xgc/h5GYCm6rZQ6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s2KveN6/xQLdLHBDCWdWeeJKQVKvTxgZEqE81rNg8Cl37dDWjN4YJgaHr8albVHWs03DTNT8q+/GLCy2H/posQAElZdik0fU4Ik7DNW0tIvfzxZ13EkZYScuhgninomPnTppLVr7jwo99gNUH7NDRbs8eFsplGXYVKhA8eUoCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=vWVMIe58; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="vWVMIe58"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id B59C7BD152
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 11:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1736422537;
	bh=ih1Twwiqmt87sULjoF0o1mtEI05xgc/h5GYCm6rZQ6w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=vWVMIe58R05EIBrz1FYx7z9zPZDKlwIBgNyozlA9f847n6o2gKGRrWavoSDWl+IQk
	 +bPoiPdKuhkAgu++vIsbcENzA5c7JM0mEj/clj4mIB0img+61eKIsBAsYslkKoXHgg
	 KdNCaFU8L2LesJLc4+DX5Lg70IFq0g6zM6vHaKq0=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 4D4DA2C0044
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 11:35:37 +0000 (GMT)
Message-ID: <250c7d83-b7c2-44f0-9975-15132ae9d2b1@philpem.me.uk>
Date: Thu, 9 Jan 2025 11:35:37 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear UNIT
 ATTENTION"
To: linux-ide@vger.kernel.org
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <Z36GMwr49ihd2nAG@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/01/2025 14:05, Niklas Cassel wrote:
 > Since we see that the drive name is printed, the ATAPI IDENTIFY command
 > succeded (ATA_CMD_ID_ATAPI (0xA1)).
 >
 > The command that timed out is ATA_CMD_PACKET 0xA0, so a regular ATAPI 
command.

Aha - I'd tried to debug that, but thought it was a SCSI command code, 
not an ATA one.

Is there a way to find out what CDB or ATAPI packet was sent to the drive?
If necessary I can probably build a custom kernel and add some 
printk()'s but I'm hoping I don't need to!


 > The UNIT ATTENTION print is just from atapi_eh_clear_ua(), which 
seems to be
 > called by ata_eh_recover() unconditionally for ATAPI devices, because 
they
 > always need to clear UNIT ATTENTION after a reset:
 > 
https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libata-eh.c#L3232-L3234
 >
 > But the reset is of course only triggered because a command has timed 
out.

I wouldn't be surprised if the failure to clear Unit Attention turned 
out to be a quirk in the Zip 100 ATAPI's ATA/ATAPI or SCSI 
implementation. They were known 'in the day' to have a few bugs [1] [2].

In any case the SATA bus reset (see larger log) sequence seems to get it 
talking again, though obviously it's not ideal.


FWIW, the drive I have is the ATAPI3 model variant, with 12.A firmware.
The pages I linked mention a "drive A:" mode - I tried that, but all it 
did was change part of the IDENTIFY response to read "FLOPPY".



[1]. 
<https://web.archive.org/web/20030207213746/http://iomega.com/software/betapatch.html>

[2]. 
<https://web.archive.org/web/20030212130255/http://pw2.netcom.com/~deepone/zipjaz/atapi.html>

Thanks
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
