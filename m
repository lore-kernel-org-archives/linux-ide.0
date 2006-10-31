From: "Danny Sung" <dsung@lantronix.com>
Subject: RE: SATA driver issues?
Date: Mon, 30 Oct 2006 18:24:17 -0800
Message-ID: <2F0FC2A92C0B154BB406D5E74CB3E6930336BD77@3putt.int.lantronix.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ltrxmail.lantronix.com ([67.134.254.86]:56072 "EHLO
	double-bogey.int.lantronix.com") by vger.kernel.org with ESMTP
	id S965529AbWJaCYW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Oct 2006 21:24:22 -0500
Content-Class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Danny Sung <dsung@lantronix.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

An update to some of the SATA issues I've had with the IBM xSeries 326m.
I decided to try out RedHat Enterprise Linux 4 (Update 4), since that's
theoretically something that IBM supports and has tested with.  In all
cases I've been using i386 (Fedora and Redhat) even though this is a
64-bit Opteron.

Turns out the first motherboard actually did have some sort of bizarre
motherboard/controller problems.  IBM's hardware support service is
always first class, and they got that switched out for me that day.  The
new hardware passed the diagnostics that came with the computer,
definitely a good sign.  However, both Fedora and RHEL still saw drive
problems.  At this point, I'm not sure there's anything I can do but
return the hardware.

But I'm just curious if anyone's used this machine successfully with
Linux and SATA drives?  Searching around the net, I did find numerous
reports of people with "abnormal status 0xd0" problems with nary a
resolution.

On a similar topic does anyone have suggestions for good quality stable
machines (either through IBM or otherwise) they can recommend?  I know
it's not completely on topic for this list, but where do you go when
looking for server-type machines with good support that are Linux
friendly?

Thanks,
Danny

(Kindly ignore the disclaimer below)
**********************************************************************
This e-mail is the property of Lantronix. It is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential, or otherwise protected from disclosure. Distribution or copying of this e-mail, or the information contained herein, to anyone other than the intended recipient is prohibited.

