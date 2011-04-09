From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Fri, 08 Apr 2011 20:48:09 -0400
Message-ID: <4D9FACC9.7020200@teksavvy.com>
References: <C1438B59050E1B4C9482FF3266AD6BA32C7493557A@gretna.indigovision.com> <C1438B59050E1B4C9482FF3266AD6BA32C7493559F@gretna.indigovision.com> <4D9CD275.9000002@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C749358D0@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C749358D0@gretna.indigovision.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 11-04-08 08:43 AM, Bruce Stenning wrote:
> Hi Mark,
> 
>> On 11-04-06 10:57 AM, Bruce Stenning wrote:
>>> [...]
>>>
>>> The following changeset was seen as a strong candidate for addressing
>>> this problem:
>>>
>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=933cb8e5fcdebd4b666165e3f039f814d62b0e52
>>
>> That changeset is already in upstream kernels (kernel.org).
>> Does the latest kernel (2.6.38) w/ sata_mv work ?
> 
> The 2.6.38.2 kernel still exhibits the same lockups that we see with the
> 2.6.26 kernel.

Okay.  Just to help narrow it down a bit, how does 2.6.32 behave ?

Thanks.
