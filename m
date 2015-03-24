From: Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [RFC PATCH] sg3_utils: Added hybrid information log utility
Date: Tue, 24 Mar 2015 15:07:55 -0400
Message-ID: <5511B60B.6060409@interlog.com>
References: <20141029195400.5225.96984.stgit@stg-AndroidDev-VirtualBox> <20141029195720.5225.51331.stgit@stg-AndroidDev-VirtualBox> <5473CE5C.7010300@ubuntu.com> <372C7AE269BA5E4D92B1082F530ED4B88A13F692@ORSMSX110.amr.corp.intel.com> <548F80CA.8010900@ubuntu.com> <5510CB76.3030709@ubuntu.com>
Reply-To: dgilbert@interlog.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.infotech.no ([82.134.31.41]:34365 "EHLO smtp.infotech.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413AbbCXTIW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2015 15:08:22 -0400
In-Reply-To: <5510CB76.3030709@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>, "Akers, Jason B" <jason.b.akers@intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "Karkra, Kapil" <kapil.karkra@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 15-03-23 10:27 PM, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On 12/15/2014 07:46 PM, Phillip Susi wrote:
>> On 11/25/2014 02:13 PM, Akers, Jason B wrote:
>>> Hi Phillip, It turns out that this patch was based on an old
>>> github repository that doesn't appear to be updated. Doug
>>> Gilbert reached out after the initial RFC and directed us to his
>>> page (http://sg.danny.cz/sg/) where he has updated sg3_utils
>>> code.
>>
>>> As we continue to work through the feedback from our SSHD kernel
>>>   patches, I'm going to follow up with Doug again on sg3_utils.
>>
>> So is there a set of patches that applies to a release from that
>> web site?  Also is the source only released as tarballs?  There is
>> no source repo?
>
> Hello.  I am still beta testing an SSHD drive and would very much like
> to get some more information out of its logs and/or manipulate the
> cache pinned working set.  Is there somewhere I can get these patched
> utilities yet?

As discussed in another thread on the subject, the
sg_sat_read_gplog utility was added in the most recent
release of the package:
   http://sg.danny.cz/sg/p/sg3_utils-1.40.tar.xz

as a framework for adding ATA and SATA general purpose log
pages. This approach is consistent with the way the package
has one utility for all SCSI logs pages: sg_logs.

So if you or anyone else wants support for ATA log pages
in sg3_utils, could you please send me patches against the
sg_sat_read_gplog utility.

Doug Gilbert




