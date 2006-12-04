From: Axel Reinhold <areinhol@le-gobw.de>
Subject: ata_piix (2.4.x) on ICH7R
Date: Mon, 4 Dec 2006 11:27:24 +0100
Message-ID: <200612041027.kB4AROta030399@l0p.le-gobw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout01.sul.t-online.com ([194.25.134.80]:60098 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1758302AbWLDK2y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 05:28:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Dear Jeff,

we need ata_piix for kernel 2.4 - using current 2.4.33.4 vanilla does 
not load ata_piix on a Supermicro PDSMi+ board (ICH7R). Is there a 
patch or should we try to backport 2.6 ata_piix? No kernel messages 
ata_piix just does not load.

Axel

-- 
+----------------------------------------------------------+
| Le-go Bekleidungswerke | Fon:   +49-9281/750-299         |
|  Axel Reinhold -  CIO  | Fax:   +49-9281/750-270         |
| Am Wiesengrund 20      | eMail: Axel.Reinhold@Le-goBW.de |
| 95032 Hof              | WWW:   http://www.le-gobw.de    |
+----------------------------------------------------------+
| Bitte um Nur-Text-Mails - Office-, HTML, .EXE-Anhaenge   |
|            oeffne ich grundsaetzlich nicht.              |
+----------------------------------------------------------+

BEGIN:VCARD
VERSION:2.1
N:Reinhold;Axel
FN:Axel Reinhold
ORG:Le-go Bekleidungswerke GmbH
ADR:;;Am Wiesengrund 20;Hof;;95032;Germany
TEL;WORK:+49-9281-750-299
TEL;FAX:+49-9281-750-270
TEL;CELL:+49-172-9382465
EMAIL:Axel.Reinhold@Le-goBW.de
END:VCARD
