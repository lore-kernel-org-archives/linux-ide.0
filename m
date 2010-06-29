From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: Pls help for LibATA caused kernel temporary hung.
Date: Tue, 29 Jun 2010 03:36:58 +0200
Message-ID: <201006290336.58540.marek.vasut@gmail.com>
References: <AANLkTinbQHdo40Drqc5Ydur5lCrAktHHDig45HDrC6s1@mail.gmail.com> <4C28653E.4080908@garzik.org> <AANLkTikwbBANkzepCW1XwbfSi3vvuq8iJNtG0WAZByDV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48735 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab0F2BjS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jun 2010 21:39:18 -0400
Received: by bwz1 with SMTP id 1so466443bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 28 Jun 2010 18:39:16 -0700 (PDT)
In-Reply-To: <AANLkTikwbBANkzepCW1XwbfSi3vvuq8iJNtG0WAZByDV@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Li <simon.jiyou@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Dne Po 28. =C4=8Dervna 2010 11:09:10 Simon Li napsal(a):
> We don't expect kernel goes to temporary hung, any ideas for the fix?

=46ix the hardware ?

>=20
> On Mon, Jun 28, 2010 at 5:02 PM, Jeff Garzik <jeff@garzik.org> wrote:
> > On 06/28/2010 03:38 AM, Simon Li wrote:
> >> May 25 15:55:06 shctc-xq-ems22-me18 kernel: ata3: status=3D0x25 {
> >> DeviceFault CorrectedError Error }
> >>=20
> >> May 25 15:59:59 shctc-xq-ems22-me18 kernel: ata3: status=3D0x25 {
> >> DeviceFault CorrectedError Error }
> >>=20
> >> Jun  2 10:54:06 shctc-xm-ems21-me18 kernel: ata2: status=3D0x25 {
> >> DeviceFault CorrectedError Error }
> >>=20
> >> Jun  2 10:54:08 shctc-xm-ems21-me18 kernel: ata2: status=3D0x25 {
> >> DeviceFault CorrectedError Error }
> >>=20
> >> Jun  2 10:54:18 shctc-xm-ems21-me18 kernel: ata2: status=3D0x25 {
> >> DeviceFault CorrectedError Error }
> >=20
> > Your hardware is returning errors, which libata is dutifully report=
ing...
> >=20
> >        Jeff
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
