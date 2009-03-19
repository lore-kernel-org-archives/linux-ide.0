From: gettinther <gettinther@gmail.com>
Subject: Basic working iso
Date: Thu, 19 Mar 2009 00:30:25 +0000
Message-ID: <64630f150903181730odc15ab9s8e1c18897472d710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174bded806ceef04656de8aa
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:47356 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZCSAa3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Mar 2009 20:30:29 -0400
Received: by ewy9 with SMTP id 9so240520ewy.37
        for <linux-ide@vger.kernel.org>; Wed, 18 Mar 2009 17:30:26 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anurag Bhandari <anurag.bhd@gmail.com>, chriszurawski@gmail.com, Custom Processing Unlimited <cpunltd@gmail.com>, David Smid <david@smidovi.eu>, "dkaiser@inkteczone.us" <dkaiser@inkte>

--0015174bded806ceef04656de8aa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

OK guys,

Just so that we are on the same page and that each packager uses the
same tools, here's the basic iso based on tinyme.  All the vbox
elements are added so file sharing with the host will work (as well as
mouse integration).  I left the command for creating the link in the
bash_history (mount -t vboxsf repo /repo1) I created a /repo1
directory on the iso image for that purpose and you will have to
create a shared folder in the virtuabox menu called "repo".

Issues:
The gdm screen keeps on selecting the "default" display instead on the
"tinyme" one which is much better (IMO).  At the login screen, select
"option>configure login manager>type root password" and deselect
"circle".  Or leave it like that if you prefer.

Password for root is: root
there's a C2 user, password: c2 (I forgot to remove it so please
remove it and add your own).  Also, while working on the core, we will
need to take particular care as to who uploads packages to the repo as
each packager will need to check subsequent packages against the ones
just added.

The link to the iso:
http://www.filedropper.com/build1

Attached is the md5sum.

I created a temporary repo of Didouph's server so add the following
line to your /etc/sources.list

rpm http://santa.matoilnet.org/ core core

How about a meeting Saturday at 20h00 GMT?  That gives us 2 days to
review the iso and sort out the upload patterns.

Thank you all,  gettinther.

PS.  Don't fret about the graphics,  I didn't spend even a single
minute on those :)

PPS.  Please forward this message to whoever I missed.  I need to open
a mailing list for such messages.

--0015174bded806ceef04656de8aa
Content-Type: text/plain; charset=US-ASCII; name="Build1.iso.md5.txt"
Content-Disposition: attachment; filename="Build1.iso.md5.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fsgpclhm0

ZTg0ODk0ZWQ1ZDExMzkzMjliYjY1Y2RiMGYzNjg2ODMgIC9CdWlsZDEuaXNvCg==
--0015174bded806ceef04656de8aa--
