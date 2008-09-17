From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ata_piix: add Hercules EC-900 mini-notebook to ich_laptop short cable list
Date: Wed, 17 Sep 2008 14:29:05 -0300
Message-ID: <200809171429.06187.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:58487 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbYIQR2x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 13:28:53 -0400
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 4D7983EBC
	for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 13:29:07 -0400 (EDT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Lhpb4Ipt4DGj for <linux-ide@vger.kernel.org>;
	Wed, 17 Sep 2008 13:29:07 -0400 (EDT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id F26D33EBB
	for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 13:29:06 -0400 (EDT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id EC3182F446
	for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 14:28:47 -0300 (BRT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

diff -p -up linux-2.6.27/drivers/ata/ata_piix.c.orig linux-2.6.27/drivers/ata/ata_piix.c
--- linux-2.6.27/drivers/ata/ata_piix.c.orig	2008-09-17 13:27:43.000000000 -0300
+++ linux-2.6.27/drivers/ata/ata_piix.c	2008-09-17 13:28:42.000000000 -0300
@@ -582,6 +582,7 @@ static const struct ich_laptop ich_lapto
 	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */
 	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
 	{ 0x27DF, 0x103C, 0x30A1 },	/* ICH7 on HP Compaq nc2400 */
+	{ 0x27DF, 0x1071, 0xD221 },	/* ICH7 on Hercules EC-900 */
 	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on ACER Aspire 2023WLMi */
 	{ 0x24CA, 0x1025, 0x003d },	/* ICH4 on ACER TM290 */
 	{ 0x266F, 0x1025, 0x0066 },	/* ICH6 on ACER Aspire 1694WLMi */

