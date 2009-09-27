From: =?UTF-8?Q?David_Bala=C5=BEic?= <xerces9@gmail.com>
Subject: SATA and full-duplex?
Date: Sun, 27 Sep 2009 16:02:42 +0200
Message-ID: <9948385e0909270702s4670f785y1f45fb090eb5b282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:52647 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbZI0OCj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Sep 2009 10:02:39 -0400
Received: by fxm18 with SMTP id 18so3137297fxm.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Sep 2009 07:02:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!

In a discussion with a friend the question whether SATA support full
duplex has come up.

While there is some info on the web that explains that SATA does not
support it, unlike SAS, the firend claims that SATA does not support
full-duplex in the sense "the same line can transfer data in both
directions", but it does support sending data over the transmit pair
and receiving over the receive pair at the same time.

An example is : in NCQ setup, the drive is sending data as a response
to READ command and during that the host send another queued command
to the same drive.

Is this possible and supported by SATA ?
(I'm interested in SATA support as a standard, not as much about
current Linux support)

Regards,
David
