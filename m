From: Grant Grundler <grundler@google.com>
Subject: Re: How to assess PMP register
Date: Thu, 30 Apr 2009 09:08:43 -0700
Message-ID: <da824cf30904300908i42218a63vc5f49fada663fe5f@mail.gmail.com>
References: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:47521 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759819AbZD3QIr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2009 12:08:47 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id n3UG8jhP028709
	for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2009 09:08:46 -0700
Received: from qw-out-1920.google.com (qwk4.prod.google.com [10.241.195.132])
	by wpaz37.hot.corp.google.com with ESMTP id n3UG8Yvv002949
	for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2009 09:08:44 -0700
Received: by qw-out-1920.google.com with SMTP id 4so2517020qwk.14
        for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2009 09:08:43 -0700 (PDT)
In-Reply-To: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: s ticket <smticket@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Wed, Apr 29, 2009 at 6:49 PM, s ticket <smticket@gmail.com> wrote:
> Is there any way to read PMP registers after hardreset/softreset?

hard or soft reset of the port behind 88SX7042 or the port behind the P=
MP?

After a 88SX7042 port hard reset, will anything interesting remain on
the PMP to read?

Have you looked at sata_pmp_read_gscr() andsata_pmp_scr_read()
in drivers/ata/libata-pmp.c?

sorry, just more questions.
grant

> SATA Controller is marvell 88SX7042 and driver is sata_mv.
> I try to send 0xE4 and 0xE6 command to read/write PMP registers:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sg_io_hdr io_hdr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char cdb[SG_ATA_16_LEN];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char sb[32];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char data[4096];
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&io_hdr, 0, sizeof(io_hdr));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&cdb, 0, sizeof(cdb));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&sb, 0, sizeof(sb));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&data, 0, sizeof(data));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cdb[0] =3D SG_ATA_16;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cdb[1] =3D SG_ATA_PROTO_NON_DATA;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cdb[2] =3D SG_CDB2_CHECK_COND;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cdb[4] =3D (unsigned char)reg;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cdb[13] =3D 0xF;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cdb[14] =3D 0xe8;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.interface_id =3D 'S';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.mx_sb_len =3D sizeof(sb);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.dxfer_direction =3D SG_DXFER_NONE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.dxfer_len =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.dxferp =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.cmdp =3D cdb;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.cmd_len =3D SG_ATA_16_LEN;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.sbp =3D sb;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.pack_id =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_hdr.timeout =3D 16000;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(fd, SG_IO, &io_hdr) =3D=3D -1) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror("ioctl(=
fd, SG_IO)");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> But after 'ioctl', the SATA link fails to read SCR1 and start resetti=
ng:
>
> ata1.00: failed to read SCR 1 (Emask=3D0x40)
> ata1.01: failed to read SCR 1 (Emask=3D0x40)
> ata1.02: failed to read SCR 1 (Emask=3D0x40)
> ata1.03: failed to read SCR 1 (Emask=3D0x40)
> ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata1.01: cmd e8/00:00:00:00:00/00:00:00:00:00/0f tag 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 res 58/00:00:00:00:00/00:00:00:00:00/0f E=
mask 0x2 (HSM violation)
> ata1.01: status: { DRDY DRQ }
> ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata1.15: hard resetting link
>
> Is there any suggestion?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
