From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_nv + ADMA + Samsung disk problem
Date: Wed, 02 Jan 2008 15:55:45 +0900
Message-ID: <477B3571.6080500@gmail.com>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu> <20080101164416.GA29574@boogie.lpds.sztaki.hu> <477B0429.7040909@gmail.com> <477B0CFD.1030603@shaw.ca> <477B10F2.9000107@shaw.ca> <477B1233.3090706@gmail.com> <477B2CE4.8070602@garzik.org> <477B318E.4030309@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:62610 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbYABGzx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 01:55:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5158751rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 01 Jan 2008 22:55:52 -0800 (PST)
In-Reply-To: <477B318E.4030309@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kluo@nvidia.com, AMartin@nvidia.com, pchen@nvidia.com

Robert Hancock wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Thanks a lot for the detailed explanation.  Nvidia ppl, any ideas?
>>> FLUSH is used regularly.  We really need to fix this.
>>
>>
>> I reiterate my opinion :)  ...   We should remove ADMA support from
>> sata_nv.  It's only in a few chips, it's not appearing in any new
>> chips, and nasty problems have lingered since ADMA support was
>> introduced.
>>
>> Definitely sounds like we should disable ADMA by default for
>> 2.6.24-rc, too.
> 
> I wouldn't agree.. It's only in a few chips (CK804/MCP04), but those
> chips are very common in desktop, workstation, even some server
> machines. Given the huge number of these chips out there, problem
> reports have been quite rare.

I agree with Jeff here.  Maybe not remove but disable it by default and
when enabling warn loudly.  NCQ just doesn't enough for its cost when
the cost includes erratic behaviors.  Only very small fraction of error
cases actually make to bugzilla or this mailing list.

Nvidia gents, is there anyway (be it NDA or whatever) to get Robert or
any of us technical documentation?

Thanks.

-- 
tejun
