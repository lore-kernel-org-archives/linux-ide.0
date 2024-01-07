Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB012B61
	for <linux-ide@vger.kernel.org>; Sun,  7 Jan 2024 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+ST626x"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso775608e87.2
        for <linux-ide@vger.kernel.org>; Sat, 06 Jan 2024 23:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704611887; x=1705216687; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCexKnta6/Ve+KyJBehi+XaphTtDs1r9ospovSybme0=;
        b=g+ST626xvI/5aUv9wQlyp1SJ1PbPS20PBc3uG2MT4jj5NF0/sh+naHxwHda4vAeywf
         i5j2IXJasIQArl+o3jOaqx5eeWBNBZr1E+lC3tF+JLkhRYh09K3EB8VkMPpv9sjmw5Ms
         OUj3DrpNwhJsD97AX5+yBWX382oKmSKPsI6KTjPSVmLAouIuyvKUX33M3JZpp3SIbp6X
         DQukQqwRrhDBPT0dg2NgO/i4mT3uYorvH4NPJyCEuGRDcHB1DU1XIh8Jm7RRSOEBVKTK
         aV8/i1oD6i8QTeZWxteQh+UDf65plV+Uzm1uL9RCEvgJWayVHtvrR36MnvJudqHGWhgh
         tr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704611887; x=1705216687;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCexKnta6/Ve+KyJBehi+XaphTtDs1r9ospovSybme0=;
        b=pJ0geINy8o/RS5tOieBpXdkaf79eZgs5nxPFmR96vvtaWXvokmTHa8TwJPjWb/Xddp
         000rudtj7cfMuJPaJoWrSfkbmy2nCybXzdB8v1v/jiTw7lSAP/7/TyE7v9fK4DXMJu0b
         hlp1eSZUSR6rG033eKrurYBqLaeJbxAuPmffueV8/bU3V0s0HmpHk73ocdirDCu9f6N9
         wSPHNs/eyiX5Qoo57oSTFuXv74MAz0vfnWxeJCsFu056I8BsWAC2fjz7cERauKKFMPxU
         Z75U3afBpwoMeaUwruHQRNgvcjYKgfS4SEvR8On2vvd0vEhmO56cEL/El8A75y32u5FL
         UlYg==
X-Gm-Message-State: AOJu0YyFksijW7Mk5fVTWk237FZcMDOboJg0KD/CFJ37eWqqzFmEQBV1
	o8RokPIzKgJ66IYba84sSsGepTKZqkFzgI3AgXPuVmDqViJvsA==
X-Google-Smtp-Source: AGHT+IGbHOCeBOU/1ZzK4jvjEx5qRY4xfBAsxZMQYxu3wiXRHkrU8RTAZQti1CeTh8hhEqmpCph5836jUV2j+MB3yc0=
X-Received: by 2002:a05:6512:3b24:b0:50e:55bb:a453 with SMTP id
 f36-20020a0565123b2400b0050e55bba453mr831014lfv.3.1704611887265; Sat, 06 Jan
 2024 23:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anthony Rossomano <trossoma2@gmail.com>
Date: Sat, 6 Jan 2024 23:17:56 -0800
Message-ID: <CA+H-W5JDJ4zBM3de0KF177eusLZ10o5fZ-To=J5a+aNgt8=O+w@mail.gmail.com>
Subject: ATA link drop-outs
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.. Been chasing an issue with ATA link drop-outs and wanted to
run this by some SMEs.
System Information
Distro: AlmaLinux 8.8
Kernel: 4.18.0-477.13.1
Arch: x64
OpenZFS Version: 2.1.5-1

The dropouts are occurring with SSD drives that are attached to
Marvell 88SE9235 SATA controllers via Marvell 88SM9705 port
multipliers. The SSD drives are M.2 form factor and are typically
models from WD or SanDisk. When the issue occurs, communication with
all SSD drives (5) connected to port multiplier is lost and the driver
performs recovery steps in order to re-establish connection with the
SSD drives. This results in ZFS I/O errors being reported from zpool
status. Multiple events with unsuccessful recovery steps by driver can
lead to pool suspension.

The issue occurs with both small and large I/O workloads, though
usually takes longer to manifest with small I/O workload.

The issue DOES NOT occur with older version of CentOS and ZFS running
on same hardware.
System Information
Distribution: CentOS 7.9
Kernel Version: 3.10.0-1160.15.2
Architecture: x64
OpenZFS Version: 0.8.6-1

Have tried the following, in different combinations but issue still occurs:
Disabling NCQ
Lowering SATA speed to 3.0
Upgrading ZFS to 2.1.13
Upgrading to AlmaLinux 8.9
Changing SATA power management from max_performance -> medium_power
Changing I/O scheduler from None -> mq-deadline
Change max_sectors_kb -> 512

The issue can be reproduced as follows:
Small I/O workload: Boot-up system w/ apps that generate small
sustained I/O load on the ZFS pool and let it run w/o interaction
Large I/O workload: Use fio to generate heavy I/O workload on ZFS pool

Partial snippet from syslog that shows initial messages when drop-outs occur:
Dec 17 07:41:00.384 test01 kernel: ata7.00: failed to read SCR 1 (Emask=0x40)
Dec 17 07:41:00.384 test01 kernel: ata7.01: failed to read SCR 1 (Emask=0x40)
Dec 17 07:41:00.384 test01 kernel: ata7.02: failed to read SCR 1 (Emask=0x40)
Dec 17 07:41:00.384 test01 kernel: ata7.03: failed to read SCR 1 (Emask=0x40)
Dec 17 07:41:00.384 test01 kernel: ata7.04: failed to read SCR 1 (Emask=0x40)
Dec 17 07:41:00.384 test01 kernel: ata7.00: exception Emask 0x100 SAct
0x4200000 SErr 0x0 action 0x6 frozen
Dec 17 07:41:00.384 test01 kernel: ata7.00: failed command: WRITE FPDMA QUEUED
Dec 17 07:41:00.384 test01 kernel: ata7.00: cmd
61/0b:a8:da:66:d1/00:00:08:00:00/40 tag 21 ncq dma 5632 out
         res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 17 07:41:00.384 test01 kernel: ata7.00: status: { DRDY }
Dec 17 07:41:00.384 test01 kernel: ata7.00: failed command: WRITE FPDMA QUEUED
Dec 17 07:41:00.384 test01 kernel: ata7.00: cmd
61/15:d0:28:26:fe/00:00:06:00:00/40 tag 26 ncq dma 10752 out
         res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 17 07:41:00.384 test01 kernel: ata7.00: status: { DRDY }

Any input on this would be greatly appreciated!
