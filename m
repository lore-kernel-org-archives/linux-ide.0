From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: 2.9.29.2: ide-tape: panic when probing device at boot
Date: Sun, 03 Jan 2010 23:52:27 -0600
Message-ID: <4B41821B.3050705@gmail.com>
References: <4A062702.8020404@kernel.org> <201001040115.o041FCEA025051@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:48881 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab0ADFwb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 00:52:31 -0500
In-Reply-To: <201001040115.o041FCEA025051@turbo.physics.adelaide.edu.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Tejun Heo <tj@kernel.org>, petkovbb@gmail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 01/03/2010 07:15 PM, Jonathan Woithe wrote:
>>>> Should I just push commit 1e75540ec5202cae63cd238c86bd880e3d496546
>>>> ("ide-tape: remove back-to-back REQUEST_SENSE detection") to Linus
>>>> or there is more needed to bring ide-tape to the world of living?
>>>
>>> ... and I'm afraid we'll have to do some serious bugfixing since this
>>> driver is behaving really funny :). Stay tuned, I'm on it.
>>
>> Cool.
>
> Has there been any movement on this in recent months?  I gave 2.6.30 a whirl
> on the machine when that was released but it still gave major problems with
> the ide-tape driver.  Is 2.6.32 likely to be improved?  If so I'll make
> arrangements to test that version.
>
> Presently I'm stuck with 2.6.24.x on this system since ide-tape holds
> together enough on this version to work.  I really want to upgrade to a more
> recent kernel but obviously I can't until ide-tape is functional again.

You could also try using libata instead of IDE drivers and see if they 
work any better for you..
