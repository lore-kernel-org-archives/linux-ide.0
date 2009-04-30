From: s ticket <smticket@gmail.com>
Subject: How to assess PMP register
Date: Thu, 30 Apr 2009 09:49:52 +0800
Message-ID: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:47046 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbZD3Btx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Apr 2009 21:49:53 -0400
Received: by gxk10 with SMTP id 10so3253869gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 29 Apr 2009 18:49:52 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Is there any way to read PMP registers after hardreset/softreset?
SATA Controller is marvell 88SX7042 and driver is sata_mv.
I try to send 0xE4 and 0xE6 command to read/write PMP registers:

	struct sg_io_hdr io_hdr;
	unsigned char cdb[SG_ATA_16_LEN];
	unsigned char sb[32];
	unsigned char data[4096];

	memset(&io_hdr, 0, sizeof(io_hdr));
	memset(&cdb, 0, sizeof(cdb));
	memset(&sb, 0, sizeof(sb));
	memset(&data, 0, sizeof(data));

	cdb[0] = SG_ATA_16;
	cdb[1] = SG_ATA_PROTO_NON_DATA;

	cdb[2] = SG_CDB2_CHECK_COND;
	cdb[4] = (unsigned char)reg;
	cdb[13] = 0xF;
	cdb[14] = 0xe8;

	io_hdr.interface_id = 'S';
	io_hdr.mx_sb_len = sizeof(sb);
	io_hdr.dxfer_direction = SG_DXFER_NONE;
	io_hdr.dxfer_len = 0;
	io_hdr.dxferp = NULL;
	io_hdr.cmdp = cdb;
	io_hdr.cmd_len = SG_ATA_16_LEN;
	io_hdr.sbp = sb;

	io_hdr.pack_id = 0;
	io_hdr.timeout = 16000;
        if (ioctl(fd, SG_IO, &io_hdr) == -1) {
		perror("ioctl(fd, SG_IO)");
		return -1;
	}

But after 'ioctl', the SATA link fails to read SCR1 and start resetting:

ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: cmd e8/00:00:00:00:00/00:00:00:00:00/0f tag 0
         res 58/00:00:00:00:00/00:00:00:00:00/0f Emask 0x2 (HSM violation)
ata1.01: status: { DRDY DRQ }
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link

Is there any suggestion?
