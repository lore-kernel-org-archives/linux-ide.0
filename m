From: Tejun Heo <tj@kernel.org>
Subject: Re: ATAPI question
Date: Wed, 04 Mar 2009 10:44:57 +0900
Message-ID: <49ADDD19.4070605@kernel.org>
References: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com> <49A8AAC6.2090201@gmail.com> <49AA84E4.3050108@kernel.org> <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCEDF6@azsmsx504.amr.corp.intel.com> <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057418@azsmsx504.amr.corp.intel.com> <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057D00@azsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42069 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbZCDBok (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2009 20:44:40 -0500
In-Reply-To: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057D00@azsmsx504.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Foster, Doug F" <doug.f.foster@intel.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

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
tejun
