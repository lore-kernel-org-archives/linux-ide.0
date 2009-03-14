From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 20/73] pata_efar: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 19:45:22 +0000
Message-ID: <20090314194522.2e8bbaa1@lxorguk.ukuu.org.uk>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
	<alpine.BSF.1.00.0903142014190.59456@anduin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33068 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753983AbZCNTol convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:44:41 -0400
In-Reply-To: <alpine.BSF.1.00.0903142014190.59456@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Inge =?ISO-8859-14?B?Qm9sc/g=?= <knan-lkml@anduin.net>
Cc: linux-ide@vger.kernel.org

On Sat, 14 Mar 2009 20:14:34 +0100 (CET)
Erik Inge Bols=F8 <knan-lkml@anduin.net> wrote:

> No functional changes in this patch.
> (Looks like it could use one, though.)

Yep - wrong comment. The EFAR is a sort of clone of the PIIX and I copi=
ed
the comment while EFAR don't appear to have copied the limitation
