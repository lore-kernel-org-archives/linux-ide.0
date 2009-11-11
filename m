From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Wed, 11 Nov 2009 17:37:17 -0500
Message-ID: <4AFB3C9D.4020609@rtr.ca>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com> <4AF8F363.3010806@rtr.ca> <200911101651.24912.bzolnier@gmail.com> <84144f020911100808y55f5bfa2v5c203b356583a7b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:60767 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759524AbZKKWhN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Nov 2009 17:37:13 -0500
In-Reply-To: <84144f020911100808y55f5bfa2v5c203b356583a7b5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Thiago Farina <tfransosi@gmail.com>, jgarzik@pobox.com, mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On Tue, Nov 10, 2009 at 5:51 PM, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
>>> I have to go off and research some silly macro and verify that
>>> it does the right thing.
>> You did it already and the macro name is quite descriptive so you
>> may as well just ACK the patch now.. ;)
> 
> Indeed. We use the "silly macro" everywhere in the kernel for code clarity.
..

Looks like unnecessary churn and obfuscation to me.

-ml
