From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15884] cd-burning reduces other simultaneous IO performance
Date: Thu, 13 May 2010 02:24:23 GMT
Message-ID: <201005130224.o4D2ONER002123@demeter.kernel.org>
References: <bug-15884-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60170 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab0EMCYY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 May 2010 22:24:24 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4D2ONYX002124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 13 May 2010 02:24:23 GMT
In-Reply-To: <bug-15884-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D15884





--- Comment #8 from Robert Hancock <hancockrwd@gmail.com>  2010-05-13 0=
2:24:17 ---
The -immed flag to wodim may improve the situation, if you can make k3b=
 add it
to the wodim command line somehow:

       -immed Tell  wodim  to  set  the  SCSI  IMMED  flag in certain c=
ommands
              (load/eject/blank/close_track/close_session).  This can b=
e  use-
              ful  on  broken systems with ATAPI harddisk and CD/DVD wr=
iter on
              the same bus  or  with  SCSI  systems  that  don=E2=80=99=
t  use  discon-
              nect/reconnect.   These  systems  will  freeze while blan=
king or
              fixating a CD/DVD or while a DVD writer is filling up a  =
session
              to the minimum amount (approx. 800 MB).  Setting the -imm=
ed flag
              will request the command to return immediately while the =
 opera-
              tion proceeds in background, making the bus usable for th=
e other
              devices and avoiding the system freeze.  This is an exper=
imental
              feature  which  may  work  or not, depending on the model=
 of the
              CD/DVD writer.  A correct solution would be to set up a  =
correct
              cabling but there seem to be notebooks around that have b=
een set
              up the wrong way by the manufacturer.  As it  is  impossi=
ble  to
              fix this problem in notebooks, the -immed option has been=
 added.

              A second experimental feature of the  -immed  flag  is  t=
o  tell
              wodim  to  try  to  wait short times while writing to the=
 media.
              This is expected to free the IDE bus if the  CD/DVD  writ=
er  and
              the  data  source  are  connected to the same IDE cable. =
In this
              case, the CD/DVD writer would otherwise usually  block  t=
he  IDE
              bus  for  nearly all the time making it impossible to fet=
ch data
              from the source drive. See also minbuf=3D and -v option.

--=20
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Demai=
l
------- You are receiving this mail because: -------
You are watching the assignee of the bug.