From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] libata: provide the ability to disable a disk via the
 params.
Date: Thu, 12 Dec 2013 21:36:55 +0100
Message-ID: <52AA1E67.6000801@linux.com>
References: <1386464187-6993-1-git-send-email-robbat2@gentoo.org> <20131212133935.GA32683@htj.dyndns.org> <robbat2-20131212T200207-028507804Z@orbis-terrarum.net>
Reply-To: Levente Kurusa <levex@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <robbat2-20131212T200207-028507804Z@orbis-terrarum.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi, Robin.

2013-12-12 21:22, Robin H. Johnson:
> On Thu, Dec 12, 2013 at 08:39:35AM -0500, Tejun Heo wrote:
>> Hello, Robin.
>>
>> On Sat, Dec 07, 2013 at 04:56:27PM -0800, Robin H. Johnson wrote:
>>> +		{ "disable",	.horkage_on	= ATA_HORKAGE_DISABLE },
>>> +		{ "nodisable",	.horkage_off	= ATA_HORKAGE_DISABLE },
>> Given the current usage of ATA_HORKAGE_DISABLE, I don't think we need
>> "nodisable".  Let's just add "disable" for now.  Can you please update
>> the patch and resend?
> Before I do so, I have two questions:
> 1.
> Countering your nodisable comment, would it be valid to do:
> libata.force=2:disable libata.force=2.02:nodisable
> To disable all of port 2 except device 2?

I think that makes sense and I support having 'nodisable'.
>
> 2. One of my friends wondered if it would be worthwhile to add force
> keywords for other HORKAGE bits, and if so, should the
> ata_lflag/ata_link force bits also be presented?

I don't think so. Most of the other HORKAGEs are automatically
recognized and applied by the code. I think the only ones
which can cause trouble if not detected at first are the ones that are
currently in the list.

-- 
Regards,
Levente Kurusa
