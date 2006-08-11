From: "Troy T Davidson" <DAVIDSON@iomega.com>
Subject: Help with SATA HDD IO Stack question
Date: Fri, 11 Aug 2006 10:53:28 -0600
Message-ID: <DB78FCDE9F1F9F4886F784EE5733F2D004339842@royntex01.iomegacorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.84]:36076 "EHLO
	email-out1.iomega.com") by vger.kernel.org with ESMTP
	id S1750778AbWHKQxb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Aug 2006 12:53:31 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Gary Poppitz <poppitzg@iomega.com>

Jeff

Let me introduce my self and then explain the why I am emailing you...

My name is Troy Davidson, I am the Senior Software Architect for Iomega=
 corporation.
We are in the development of a Linux based NAS product, that is based o=
f the 2.6.13 kernel. We are attempting to add RAID HDD "HotSwap support=
", the HDDs are SATA drives running of a Silicon Image Host controller.

Now the problem:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 The 2.6.18 Kernel has a critical feat=
ure such that when the SATA HDD is disconnected, the driver handles thi=
s fine and removes the device from /DEV, where as the 2.6.13 does not r=
emove the /DEV device,

What I am asking...

We would be willing to Purchase you services on consulting basis to hel=
p devise a way to add the support for the DEV removal and clean stoppin=
g of the SATA device in the 2.6.13 kernel, (if possible). If you are in=
terested or could give some directions on a solution to this I would be=
 grateful.

Thanks
Troy Davidson
Iomega Corp.



