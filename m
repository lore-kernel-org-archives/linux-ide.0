From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Tue, 10 Nov 2009 18:08:59 +0200
Message-ID: <84144f020911100808y55f5bfa2v5c203b356583a7b5@mail.gmail.com>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>
	 <4AF8F363.3010806@rtr.ca> <200911101651.24912.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:56839 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZKJQIy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Nov 2009 11:08:54 -0500
In-Reply-To: <200911101651.24912.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Thiago Farina <tfransosi@gmail.com>, jgarzik@pobox.com, mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 10, 2009 at 5:51 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
>> I have to go off and research some silly macro and verify that
>> it does the right thing.
>
> You did it already and the macro name is quite descriptive so you
> may as well just ACK the patch now.. ;)

Indeed. We use the "silly macro" everywhere in the kernel for code clarity.
