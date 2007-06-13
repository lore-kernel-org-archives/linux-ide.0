From: "Stephen Jakeman" <stephen.jakeman@ircona.com>
Subject: SATA_sil24 for 2.4
Date: Wed, 13 Jun 2007 11:44:50 +0100
Message-ID: <31F831E88F956C468206823D7BBCA4AB12F3EF@irc-dc-01>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ircona.com ([87.192.241.39]:46539 "EHLO mail.ircona.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146AbXFMKox convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jun 2007 06:44:53 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Could anybody point me to a driver for the Silicon
Image SATA 3124 controller running under linux 2.4.
I am currently using a microblaze core under uClinux
And therefore cannot use the driver for the 2.6 kernel.

If no driver is available could somebody give me some advice
As to what is the best way to back port the sata_sil24 driver
>From 2.6 to 2.4.

Regards,

Stephen Jakeman
