From: "Foster, Doug F" <doug.f.foster@intel.com>
Subject: RE: ATAPI question
Date: Wed, 4 Mar 2009 08:44:42 -0700
Message-ID: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F30B7DE3@azsmsx504.amr.corp.intel.com>
References: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com>
 <49A8AAC6.2090201@gmail.com> <49AA84E4.3050108@kernel.org>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCEDF6@azsmsx504.amr.corp.intel.com>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057418@azsmsx504.amr.corp.intel.com>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057D00@azsmsx504.amr.corp.intel.com>
 <49ADDD19.4070605@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47261 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbZCDPov convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Mar 2009 10:44:51 -0500
In-Reply-To: <49ADDD19.4070605@kernel.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Foster, Doug F" <doug.f.foster@intel.com>


-----Original Message-----
From: Tejun Heo [mailto:tj@kernel.org]
Sent: Tuesday, March 03, 2009 6:45 PM
To: Foster, Doug F
Cc: Robert Hancock; linux-ide@vger.kernel.org
Subject: Re: ATAPI question

Hello, Foster.

Foster, Doug F wrote:
> I posted several traces on an FTP server.  To view them, you will
> need to download the LeCroy SASSuite software.
>
> The FTP server is a blind site and the files will only remain there
> for 24-hours.
>
> How to retrieve the files from the FTP server:
> (My apologies for the Windows directions.  Just do the equivalent in
> Linux.)
>
> Open cmd.exe prompt
>
>> ftp ftp.intel.com
> User: anonymous
> Password: <Enter anything here>
> ftp>
> ftp> binary
> ftp> cd pub/outgoing
> ftp> pwd
> ftp> lcd c:\temp
> ftp> get ATAPI_1_Plextor.sas
> ftp> get ATAPI_3_Plextor.sas
> ftp> get ATAPI_4_Plextor.sas
> ftp> get ATAPI_5_LiteOn.sas
> ftp> get ATAPI_6_LiteOn.sas
> ftp> get ATAPI_7_LiteOn.sas
> ftp> get ATAPI_8_Plextor.sas
> ftp> quit

I can't get them.

  ftp> pwd
  257 "/pub/outgoing" is current directory.
  ftp> get ATAPI_1_Plextor.sas
  local: ATAPI_1_Plextor.sas remote: ATAPI_1_Plextor.sas
  229 Entering Extended Passive Mode (|||51535|)

And then nothing.  Or do I have to use active mode?  Any chance you
can put them somewhere more accessible?  Preferably http?

Thanks.

--
Tejun

++++++++++++++++++++++
Tejun, I will find an alternate way to post later today.  I just tested with a CentOS machine.

. . . .
ftp> get ATAPI_1_Plextor.sas
local: ATAPI_1_Plextor.sas remote: ATAPI_1_Plextor.sas
227 Enter Passive Mod(198,175,98,65,49,58)
150 Opening BINARY mode data connection for ATAPI_1_Plextor.sas (197520504 bytes
226 Tranfer complete.
197520504 bytes received in 1.2e+02 seconds (1.7e+03 Kbytes/s)
ftp>

Can you try again?  Obviously, the files are big.
