From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Disabling Command Completion Coalescing (CCC) in SATA AHCI
Date: Mon, 23 May 2011 14:27:16 -0600
Message-ID: <BANLkTikyf+O5Cb1jvxmyzN4m+ekLLS5xPA@mail.gmail.com>
References: <BANLkTinPkdTkOQHNnPHwtXq2SMCo-uAALA@mail.gmail.com>
	<4DD5CE76.9040003@gmail.com>
	<BANLkTimpTh6Tmw0ZcTYaofayKKVKaCa4iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41431 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933515Ab1EWU1R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2011 16:27:17 -0400
Received: by iwn34 with SMTP id 34so5113693iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 23 May 2011 13:27:16 -0700 (PDT)
In-Reply-To: <BANLkTimpTh6Tmw0ZcTYaofayKKVKaCa4iw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pallav Bose <pallavbose@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org

On Mon, May 23, 2011 at 8:36 AM, Pallav Bose <pallavbose@gmail.com> wrote:
> Hello Robert, Sergei,
>
> Thank your for your replies.
>
> On Thu, May 19, 2011 at 10:14 PM, Robert Hancock <hancockrwd@gmail.com> wrote:
>>
>> I suspect that there is something going on that you're not accounting for. Are you sure that you're not getting multiple outstanding writes in parallel somehow? Although the controller won't batch completions, the drive is free to do so if there are multiple queued commands outstanding at once (it can send a Set Device Bits FIS with multiple bits set).
>
> I don't believe this is the case because a write request is sent only
> _after_ the previous write request's response is received.
>
> You mentioned that the drive is free to batch completions if there are
> multiple queued commands outstanding at the same time. Is there a way
> to disable this feature? If my understanding is correct, since CCC is
> out of the picture, the drive is the only one that could be batching
> the responses? Or are there other possible candidates?!

I don't think there's any way to disable it in the drive, the firmware
either decides to do that or it doesn't. Of course if the commands are
truly being serialized then this shouldn't be able to happen either.

>
> On Fri, May 20, 2011 at 6:49 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
>> I don't understand. This controller is not AHCI, and not even SATA one.
>
> Sorry about that. I should have been more careful when pasting the
> output of lspci. Here is the SATA controller:
>
> RAID bus controller: Intel Corporation 82801 SATA RAID Controller (rev 02)
>
> Regards,
> Pallav
>
