Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65A1E3DED
	for <linux-ide@vger.kernel.org>; Wed, 21 May 2025 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858501; cv=none; b=aVJ/jtfNLznvYH9QDA2FVm/wc5qgEI9SPQC/jLzmyNOOODvk+2rBHqROyW0iwITUsL6L46NEITgyopRWy9/Z/rlYf4n84BgI0nEYYOZdbedgW3ikw4FDb5FO0frWU7Vmfnupj3GyQyinJbgiVJVEQFj8a9SojpB7Bp8En/vUi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858501; c=relaxed/simple;
	bh=8rtXL+Pt2j7UU10LgsoVfvPy9qmfd9b2Ilr6fUSENqU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nhbMovIItANqsnC/XBi05IrLt0xByAHnLXoyMLBv6/vpgvKDqffIuuW+DRt1n3oyjUuH1Lt4IrHvepMHIZt+fP0DJLk6/w6UL0T1iufvVfC+GeyTAUQ6pEeLGkb/3+htnhR+EyeMuTHJdd50ZNluZCp4ExbC+JW4/AKYKmeRzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLLvku2V; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLLvku2V"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3109fb9f941so1100953a91.3
        for <linux-ide@vger.kernel.org>; Wed, 21 May 2025 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747858498; x=1748463298; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4EruKC6E2l9By45BTfKfOjq/9SepeqLuOQMwnj5gTOs=;
        b=dLLvku2V7DBpE/cPW6aiJpxbcBzG4znSZQreigLYxcMbU/bPYj68El2fz0MyytMgV/
         9TymZ+HYJWoIvgYRnc/eTM3AAtl1kEHS3Bm8Nl9t5rohCIbSpTjRP6HXRVK72hT/mRou
         r4TDi0/l62Kb7GKZ4Go+vXixSekh56OrD0F+23FdI+57iYUyt8KeZJ7SX6xB1fQFMR6/
         nz/0NiiLvnyr2koka+vamOCNTo0hbVrTOk+iNXb6hv+HezkFEj2gTwnHjMVXC/Gh5IKE
         wZM8BzOaFkShvaurCqOPqXxA1OqbTj9ZaWnlwxyKjHw1sCRPEuYBdaCFnfBCDlwF8/1X
         dUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747858498; x=1748463298;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4EruKC6E2l9By45BTfKfOjq/9SepeqLuOQMwnj5gTOs=;
        b=S8fF0vpVlyPLAgdoNCvLjuh7G1wWSJ6HaSBX6dIGLxRgHT2ae9MW5EyoCT7ZQZ7qPx
         jtAXRWEXWo9qUjOrw3THuqSXpFptB2Kndk16I4EPqmJ2Ui3oR+lROccXHvmQ0zOgrpEL
         Mt+zcGahdbOgn/dt1TI0qoJeCYsC4eVsrMJrGwSswFWKnYqpt3UYBIrhwhux3BwNjGqe
         Lgcyi/kk8T0yGvxv1zDUnBs29HJrN/Tw5g2dr52p2bzX+FBgykfk1oSRZbz5Pa8rIFaM
         9+/7XGOlp58kvJRjFGPre+s3Q5tHQfAcyvCFT0EVQiM/LzriYV5hqTmuc0/PYZx/Oo+Q
         vkCw==
X-Gm-Message-State: AOJu0YwnPqvxf7Iui1PufWI9c4tqR3Q1NHN5l5xSTkEeHW3OXXK8AzeJ
	+4jIRrqb02jhAc+3m3WK9nHscZR2soXHrANxuSeORIANNjjOjz2Pt3EyfXsG3sQt4HVmibx3MKq
	ioEW3T9fOOlOBf2pZYqT+qdbtojci/3wVjUbefes=
X-Gm-Gg: ASbGncspn074iNYhEyo88mtL7aCLaQd6n8XouzARKOf9cvB6L2rA+yG7Dzdcx7XbS3w
	HdUOtWfXJfYevogKFAaljrmCz61+BXO2UCOUwjQ5H0egL5vieHgN2DtRe/vmEbSMQGIP7JLrVBE
	PutdfhXvWQ5leFW1pnsSvoeiyDAP+iB0H14DijS0z4K17kuIhv6QoIz7sSHtQowZoxEg==
X-Google-Smtp-Source: AGHT+IG1iRwsqjgIR7WDb0+UYblbDLyZWsMh9a4uQrNwd07hO7gs2hdXpJuW6gLm4N5QpN7VtwdoOpENUDjOMBVF0B8=
X-Received: by 2002:a17:90b:3f4c:b0:2ee:5958:828 with SMTP id
 98e67ed59e1d1-30e7d522155mr37951168a91.9.1747858498507; Wed, 21 May 2025
 13:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ioannis Barkas <jnyb.de@gmail.com>
Date: Wed, 21 May 2025 23:14:47 +0300
X-Gm-Features: AX0GCFvtEluFDq5hYK-frIekiYdBqvZACUI9XHycICfNh54MhHDzk4XOW7WSLO8
Message-ID: <CADUzMVYk1VOB9u2n4Bxd=ZBeDspkorP94HqA9H1zb6QSDxmFbg@mail.gmail.com>
Subject: Re: [PATCH v2] ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello guys!

cdrecord -vvv -atip produces an error using my AD-7200A on VT6415
controller at my installation as you can see below:

cdrecord -vvv -atip
TOC Type: 1 = CD-ROM
Device was not specified. Trying to find an appropriate drive...
Detected CD-R drive: /dev/sr0
Using /dev/cdrom of unknown capabilities
scsidev: '/dev/cdrom'
devname: '/dev/cdrom'
scsibus: -2 target: -2 lun: -2
Error trying to open /dev/cdrom exclusively (Device or resource
busy)... retrying in 1 second.
Error trying to open /dev/cdrom exclusively (Device or resource
busy)... retrying in 1 second.
Error trying to open /dev/cdrom exclusively (Device or resource
busy)... retrying in 1 second.
Error trying to open /dev/cdrom exclusively (Device or resource
busy)... retrying in 1 second.
Error trying to open /dev/cdrom exclusively (Device or resource
busy)... giving up.
scsidev: '-1'
devname: '-1'
scsibus: -2 target: -2 lun: -2
wodim: No such file or directory.
Cannot open SCSI driver!
For possible targets try 'wodim --devices' or 'wodim -scanbus'.
For possible transport specifiers try 'wodim dev=help'.
For IDE/ATAPI devices configuration, see the file README.ATAPI.setup from
the wodim documentation.

But if I use wodim it works:
wodim --devices
wodim: Overview of accessible drives (1 found) :
-------------------------------------------------------------------------
 0  dev='/dev/sg0'    rwrw-- : 'Optiarc' 'DVD RW AD-7200A'
-------------------------------------------------------------------------

wodim dev=/dev/sg0 -atip
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   :
Vendor_info    : 'Optiarc '
Identification : 'DVD RW AD-7200A '
Revision       : '1.09'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96R RAW/R96R
ATIP info from disk:
  Indicated writing power: 4
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type A, high Beta category (A+) (3)
  ATIP start of lead in:  -11849 (97:24/01)
  ATIP start of lead out: 336076 (74:43/01)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 25
Manufacturer: Taiyo Yuden Company Limited

This is the output from an ancient TDK CD using 80 conductor cable to
connect AD-7200A on VT6415. Device is getting UDMA 4. Testing was
performed at 32bit MX Linux with kernel 6.1 at P4i945GC. Old good
Pentium 4 with 1 core powering 20 PCIe lanes. 20+ years later and most
PCs are stuck to 20 or 24 PCIe lanes while there are 64 or even 128
cores now plus NPUs. Something feels awfully wrong here...

The same command works when cable is attached to the IDE port of ICH7:
cdrecord -vvv -atip
Device was not specified. Trying to find an appropriate drive...
Detected CD-R drive: /dev/sr0
Using /dev/cdrom of unknown capabilities
scsidev: '/dev/cdrom'
devname: '/dev/cdrom'
scsibus: -2 target: -2 lun: -2
Linux sg driver version: 3.5.27
Wodim version: 1.1.11
Using libusal version 'Cdrkit-1.1.11'.
SCSI buffer size: 64512
Beginning DMA speed test. Set CDR_NODMATEST environment variable if device
communication breaks or freezes immediately after that.
 01 00 00 01 00 00 00 00
 01 AA 01 01 00 00 00 00
 01 00 A0 00 00 00 00 01 00 00 00 00
 01 00 A1 00 00 00 00 00 00 00 00 00
 01 00 A2 00 00 00 00 00 00 00 00 00

Also this works:
 sudo wodim dev=/dev/sg0 -atip
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   :
Vendor_info    : 'Optiarc '
Identification : 'DVD RW AD-7200A '
Revision       : '1.09'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96R RAW/R96R
ATIP info from disk:
  Indicated writing power: 4
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type A, high Beta category (A+) (3)
  ATIP start of lead in:  -11849 (97:24/01)
  ATIP start of lead out: 336076 (74:43/01)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 25
Manufacturer: Taiyo Yuden Company Limited

Taso you can update your drive to version 1.09 and retest. Also please
share a dmesg to identify the errors you get and the kernel in use.
Output from IDE controller PCI config could be handy:
sudo lspci -nnnnvvvvxxxxks 05:00.1

Guys cable detect seems broken. With a 40 conductor cable in Linux I get:
ata3.00: ATAPI: Optiarc DVD RW AD-7200A, 1.09, max UDMA/66
also UDMA 4 is selected in hdparm while BIOS says UDMA 2

Finally cdrecord -vvv -atip command is not working properly with 40
conductor cable. I get wrong results but no hang was observed at all
during the tests.

Best regards,
Ioannis
