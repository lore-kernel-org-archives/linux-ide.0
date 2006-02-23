From: "Paul Barber" <paulrbarber@gmail.com>
Subject: Via vt8251 sata IDENTIFY DEVICE
Date: Thu, 23 Feb 2006 23:40:53 +0000
Message-ID: <78578fb70602231540p124ec941q95bdb114ec2b56dd@mail.gmail.com>
Reply-To: paul@ninj.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.204]:61395 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932129AbWBWXk5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Feb 2006 18:40:57 -0500
Received: by nproxy.gmail.com with SMTP id c31so128806nfb
        for <linux-ide@vger.kernel.org>; Thu, 23 Feb 2006 15:40:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

In SATA mode, it seems as though the vt8251 gives a correct response
to an IDENTIFY DEVICE command for device 0, but an identical response
for device 1 regardless of attached drive. Is it possible that the
vt8251 does not check the device bit?

This was tested using Via's sata_via.c.patch available here:
http://www.viaarena.com/Driver/via%20fc4.0%20sata&pata%20controller%20for%20software%20raid%20appnote%20ver0.8.gz
