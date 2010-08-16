From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] 2.6.35 libata support for > 512 byte sectors (e.g. 4K Native)
Date: Mon, 16 Aug 2010 13:24:09 -0700
Message-ID: <AANLkTi=R4GQGVE5AvU9hdWXdtqZzaOswrGQA+cPgO58W@mail.gmail.com>
References: <AANLkTikSSmP5f1csa=xPTR=EqY4D5a=6t2oDVkZ7cA-v@mail.gmail.com>
	<CAC4B8726E86A142B27A9E9A2F2F12470149041A4E@rrsmsx505.amr.corp.intel.com>
	<AANLkTik4RNvaE5OrFq3NmZ+-9DKhAAaNQ3cdPg38zOr2@mail.gmail.com>
	<4C699455.6020200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:48157 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab0HPUYV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Aug 2010 16:24:21 -0400
In-Reply-To: <4C699455.6020200@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Wilcox, Matthew R" <matthew.r.wilcox@intel.com>, Tejun Heo <tj@kernel.org>, Linux IDE <linux-ide@vger.kernel.org>, Gwendal Grignou <gwendal@google.com>, LKML <linux-kernel@vger.kernel.org>

On Mon, Aug 16, 2010 at 12:41 PM, Jeff Garzik <jgarzik@pobox.com> wrote=
:
=2E..
> The main question is whether the size of a DRQ block changes, when LB=
A
> logical size changes?

Don't we already know that depends on the ATA command?

> I need to review the ATA8 specs in this area, but I
> would think some interfaces that return 512-byte pages for things lik=
e SMART
> info would be unchanged. =C2=A0How do the drives behave for PIO-Data-=
{In,Out}
> commands that are not reading/writing user data, but rather drive met=
adata?

SMART Info/Logs are meta data and as you noted unchanged.

Two other meta-data PIO commands I can think of:
o  FW update: I'm not going to risk bricking this drive to find that ou=
t.
o Vendor specific selftest/diagnostic commands (I don't know if any
exist - just a guess)

If someone from Hitachi cares to respond publicly regarding the
behavior of this "Engineering Sample", that would be appreciated and
helpful.  But feedback from any other vendor would be welcome/useful
also.

I suspect legacy tools might be needed to update firmware and those
might continue to function if DRQ block size is still 512 byte.  I'd
like to leave this hardcoded to ATA_SECT_SIZE until someone can
demonstrate a need to change it. Ok?

thanks,
grant
