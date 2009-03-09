From: "Foster, Doug F" <doug.f.foster@intel.com>
Subject: RE: ATAPI question
Date: Mon, 9 Mar 2009 14:35:26 -0700
Message-ID: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3215B07@azsmsx504.amr.corp.intel.com>
References: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com>
 <49A8AAC6.2090201@gmail.com> <49AA84E4.3050108@kernel.org>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCEDF6@azsmsx504.amr.corp.intel.com>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057418@azsmsx504.amr.corp.intel.com>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057D00@azsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:2047 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbZCIVfc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Mar 2009 17:35:32 -0400
In-Reply-To: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057D00@azsmsx504.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "Foster, Doug F" <doug.f.foster@intel.com>

Did anyone get a chance to look at these traces?
Any thoughts on what the problem is?
Any guidance on experiments that I should try?
Is there anything else that I can provide to help?

-----Original Message-----
From: Foster, Doug F
Sent: Tuesday, March 03, 2009 11:20 AM
To: Tejun Heo; Robert Hancock
Cc: linux-ide@vger.kernel.org; Foster, Doug F
Subject: RE: ATAPI question

I posted several traces on an FTP server.  To view them, you will need to download the LeCroy SASSuite software.

The FTP server is a blind site and the files will only remain there for 24-hours.

How to retrieve the files from the FTP server:
(My apologies for the Windows directions.  Just do the equivalent in Linux.)

Open cmd.exe prompt

>ftp ftp.intel.com
User: anonymous
Password: <Enter anything here>
ftp>
ftp> binary
ftp> cd pub/outgoing
ftp> pwd
ftp> lcd c:\temp
ftp> get ATAPI_1_Plextor.sas
ftp> get ATAPI_3_Plextor.sas
ftp> get ATAPI_4_Plextor.sas
ftp> get ATAPI_5_LiteOn.sas
ftp> get ATAPI_6_LiteOn.sas
ftp> get ATAPI_7_LiteOn.sas
ftp> get ATAPI_8_Plextor.sas
ftp> quit

