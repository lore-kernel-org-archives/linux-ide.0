From: Marc C <marc.ceeeee@gmail.com>
Subject: Re: [PATCH] libata: Add additional queued command opcodes from SATA spec
Date: Mon, 22 Jul 2013 13:48:14 -0700
Message-ID: <3428D7F0-83A1-4DFE-826A-4903BF5ECD76@gmail.com>
References: <CAO1A-8DmPXdM-XbzD18aQUYy4+Aph0jVwrSe1_spJJcRM57NNQ@mail.gmail.com> <20130722200014.GA4042@mtj.dyndns.org> <7D07DE2D-D421-4E79-AB4B-27566DCB3655@gmail.com> <20130722204510.GC13040@mtj.dyndns.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:39711 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab3GVUsR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jul 2013 16:48:17 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so7497525pbc.3
        for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2013 13:48:16 -0700 (PDT)
In-Reply-To: <20130722204510.GC13040@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

> Hmmm?  I don't think ata.h is visible to userland, is it?
I had done so locally so I wouldn't have to re-define all of
the opcodes.

> Let's add the opcodes when it becomes actually used in the kernel then
> unless it's gonna be a PITA on your end.
Sounds good!

Thanks,
Marc

On Jul 22, 2013, at 1:45 PM, Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Mon, Jul 22, 2013 at 01:42:42PM -0700, Marc C wrote:
>> I have some out-of-tree user apps that exploit those opcodes
>> (via uapi). I eventually will have additional patches, but cannot 
> 
> Hmmm?  I don't think ata.h is visible to userland, is it?
> 
>> submit the pull request for them until the SATA 3.2 spec is public.
> 
> Let's add the opcodes when it becomes actually used in the kernel then
> unless it's gonna be a PITA on your end.
> 
> Thanks!
> 
> -- 
> tejun

