From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: Proposed patch for IDE missing commands
Date: Thu, 3 Apr 2008 11:28:42 +0200
Message-ID: <9ea470500804030228p3077456ai4a756aa46116aa4c@mail.gmail.com>
References: <47F47324.80108@free.fr>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:20611 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037AbYDCJ2n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2008 05:28:43 -0400
Received: by wf-out-1314.google.com with SMTP id 28so3063209wff.4
        for <linux-ide@vger.kernel.org>; Thu, 03 Apr 2008 02:28:42 -0700 (PDT)
In-Reply-To: <47F47324.80108@free.fr>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xavier <x.guimard@free.fr>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

(adding Bart, linux-ide to CC:)

Hi,

On Thu, Apr 3, 2008 at 8:03 AM, Xavier <x.guimard@free.fr> wrote:
> Hi all,
>
>  I'm working for the french Gendarmerie Nationale and we've decided t=
o
> publish our patch for the kernel that provides some missing IDE comma=
nds to
> access to protected areas (HPA and DCO).
>
>  Best regards,
>  Xavier
>

Please, rebase/redo your patch against latest -rc kernel (in this case
2.6.25-rc8) und run it through
scripts/checkpatch.pl in order to adjust it to the kernel coding
style. See Documentation/CodingStyle
for details.

Thanks.

--=20
Regards/Gru=DF,
Boris
