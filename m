From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: IDE, packet commands and REQ_TYPE_SENSE?
Date: Thu, 2 Apr 2009 14:45:36 +0200
Message-ID: <9ea470500904020545q14cdad6cge385806f1d9da448@mail.gmail.com>
References: <49D48600.2070109@garzik.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:21471 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZDBMpj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 08:45:39 -0400
In-Reply-To: <49D48600.2070109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>

Hi,

> What are the differences between REQ_TYPE_ATA_PC and REQ_TYPE_BLOCK_P=
C?
> =A0Would it be possible to eliminate REQ_TYPE_ATA_PC after some work,=
 as well?

That's the plan. However, I'd like to wait for Tejun's block patches
to get settled first,
especially the convert-to-bio from rq->data bits.

--=20
Regards/Gruss,
Boris
