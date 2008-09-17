From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] piix: add Hercules EC-900 mini-notebook to ich_laptop short cable list
Date: Wed, 17 Sep 2008 14:30:39 -0300
Message-ID: <200809171430.39291.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:58522 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbYIQRaX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 13:30:23 -0400
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 209F53EBC
	for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 13:30:40 -0400 (EDT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 1Na8SPBgtIeb for <linux-ide@vger.kernel.org>;
	Wed, 17 Sep 2008 13:30:39 -0400 (EDT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id C7F1E3EBB
	for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 13:30:39 -0400 (EDT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 093492F32F
	for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 14:30:21 -0300 (BRT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
index 30cfc81..214427c 100644
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -250,6 +250,7 @@ static const struct ich_laptop ich_laptop[] = {
 	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */
 	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
 	{ 0x27DF, 0x103C, 0x30A1 },	/* ICH7 on HP Compaq nc2400 */
+	{ 0x27DF, 0x1071, 0xD221 },	/* ICH7 on Hercules EC-900 */
 	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on Acer Aspire 2023WLMi */
 	{ 0x2653, 0x1043, 0x82D8 },	/* ICH6M on Asus Eee 701 */
 	/* end marker */
