From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Is there a reliable way to ID a SSD?
Date: Thu, 30 Dec 2010 10:58:07 -0500
Message-ID: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39269 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab0L3P6a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2010 10:58:30 -0500
Received: by iwn9 with SMTP id 9so11017521iwn.19
        for <linux-ide@vger.kernel.org>; Thu, 30 Dec 2010 07:58:30 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

All,

Per T13/1699-D Revision 4a (from May 2007) word 217 of the identify
block should be populated with a "1" to identify non-rotating media.

http://www.t13.org/Documents/UploadedDocuments/docs2007/D1699r4a-ATA8-A=
CS.pdf

Does anyone know if that is a reliable field?

Specifically there are two separate issues:

1) Are all devices reporting a 1 in field 217 non-rotating?
2) Are all production non-rotating devices populating that field with a=
 1.

Is there some other reliable mechanism for identifying a SSD?


--=20
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
CNN/TruTV Aired Forensic Imaging Demo -
=A0=A0 http://insession.blogs.cnn.com/2010/03/23/how-computer-evidence-=
gets-retrieved/

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
