From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata: fixup return type of wait_for_completion_timeout
Date: Tue, 10 Feb 2015 19:38:41 +0300
Message-ID: <54DA3411.3050309@cogentembedded.com>
References: <1423557576-18984-1-git-send-email-hofrat@osadl.org> <20150210145341.GJ3220@htj.duckdns.org> <20150210155517.GB1883@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150210155517.GB1883@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>, Tejun Heo <tj@kernel.org>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 02/10/2015 06:55 PM, Nicholas Mc Guire wrote:

>> On Tue, Feb 10, 2015 at 03:39:36AM -0500, Nicholas Mc Guire wrote:
>>> -	if (!rc) {
>>> +	if (irq_timeout == 0) {

>> Why == 0 tho?  This always bothers me.  To match this style, we'd use
>> != 0 to test the other direction.  In what way is "if (ret != 0)"
>> better than "if (ret)"?  We're negating the two tests needlessly.

> The == 0 seemed better to me than ! here because it would read

>    if (not irq_timeout) {

    No, 'irq_timeout  == 0' isn't really better.

> while it actually did time out - but this could be resolved by renaming
> irq_timeout to time_left (as was suggested by Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> for a similar patch) and then it
> would read:

>     if (time_left == 0) {

> which would nicely describe the timeout state.

    '!time_left' also would.

> if that addresses your concerns then I'll fix it up and repost.

> thx!
> hofrat

MBR, Sergei
