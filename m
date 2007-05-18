From: Mika Kukkonen <mikukkon@miku.homelinux.net>
Subject: [PATCH] Add two missing chipsets to drivers/ide/ide-proc.c
Date: Fri, 18 May 2007 10:11:41 +0300
Message-ID: <20070518071141.GA2308@srv1-m700-lanp.koti>
Reply-To: mikukkon@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.boksi.fi ([195.10.143.42]:17818 "EHLO smtp1.boksi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523AbXERHRl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 May 2007 03:17:41 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, alan@redhat.com
Cc: mikukkon@iki.fi, linux-ide@vger.kernel.org

Compiling with '-Wswitch-enum' I noticed following:

  CC      drivers/ide/ide-proc.o
drivers/ide/ide-proc.c: In function =E2=80=98proc_ide_read_imodel=E2=80=
=99:
drivers/ide/ide-proc.c:54: warning: enumeration value =E2=80=98ide_etra=
x100=E2=80=99 not handled in switch
drivers/ide/ide-proc.c:54: warning: enumeration value =E2=80=98ide_acor=
n=E2=80=99 not handled in switch

How about the following patch?

Signed-off-by: Mika Kukkonen <mikukkon@iki.fi>

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index d50bd99..ea94c9a 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -67,6 +67,8 @@ static int proc_ide_read_imodel
 		case ide_4drives:	name =3D "4drives";	break;
 		case ide_pmac:		name =3D "mac-io";	break;
 		case ide_au1xxx:	name =3D "au1xxx";	break;
+		case ide_etrax100:	name =3D "etrax100";	break;
+		case ide_acorn:		name =3D "acorn";		break;
 		default:		name =3D "(unknown)";	break;
 	}
 	len =3D sprintf(page, "%s\n", name);

