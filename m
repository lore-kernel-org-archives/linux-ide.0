From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Tue, 07 Aug 2007 14:46:31 -0400
Message-ID: <46B8BE07.5020005@redhat.com>
References: <20070807054250.GQ13674@htj.dyndns.org> <20070807162529.1781b21c@the-village.bc.nu> <46B89177.2040209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53478 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761592AbXHGSrT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 14:47:19 -0400
In-Reply-To: <46B89177.2040209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

On 08/07/2007 11:36 AM, Tejun Heo wrote:
> Alan Cox wrote:
>> On Tue, 7 Aug 2007 14:42:50 +0900
>> Tejun Heo <htejun@gmail.com> wrote:
>>
>>> HDS724040KLSA80 reports that it supports HPA && LBA48 but craps itself
>>> on READ_NATIVE_MAX_EXT.  Implement BROKEN_HPA horkage and apply it to
>>> the drive.  If the horkage is set, all HPA operations are skipped.
>> I'd rather know what is going on here. A drive can legitimately
>> support LBA48 and HPA and refuse READ_NATIVE_MAX_EXT.
> 
> READ_NATIVE_MAX_EXT is mandatory if HPA && LBA48, no?
> 
>> In addition just
>> about every OS I know queries the HPA which means that something other
>> than HPA support being broken is probably at the root. We thus want to
>> find the real fix.
>>
>> What do the actual traces look like ?
>>
>> Does it crap out of it gets READ_NATIVE_MAX ?
> 
> Haven't tried that but the problem is that the drive times out
> READ_NATIVE_MAX_EXT so it doesn't really matter whether the drive
> succeeds READ_NATIVE_MAX or not.  For more detail, please read the
> following thread.
> 
>   http://thread.gmane.org/gmane.linux.ide/21322
> 

There's also this Fedora bug:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=251047#c2

...where after an error on the slave device the master starts throwing
HPA errors after the port is reset. Don't know if it's related or
not...
