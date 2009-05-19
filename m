From: =?ISO-8859-15?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 19 May 2009 15:05:25 +0100
Message-ID: <4A12BCA5.2030302@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <200905191506.00245.bzolnier@gmail.com> <4A12B200.6010706@inov.pt> <200905191556.17793.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:35866 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633AbZESOGH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 May 2009 10:06:07 -0400
In-Reply-To: <200905191556.17793.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz escreveu:
> On Tuesday 19 May 2009 15:20:00 Jo=E3o Ramos wrote:
>  =20
>> Ok, I will apply the changes, test them and then resubmit the final =
patch.
>> By the way, I will submit the final patch through 'arm-linux' mailin=
g=20
>> list, if that is OK to you, since the full patch has platform-specif=
ic=20
>> dependencies.
>> I mean, as long as we iterate with the IDE part of it untill it is g=
ood=20
>> for submission from you, I can submit it in 'arm-linux' with your=20
>> acknowledge, right?
>>    =20
>
> It is good to post it also to linux-arm for additional review & bette=
r merge
> coordination but the patch itself should go through IDE tree and linu=
x-ide.
>
> [ It is IDE host driver, has also IDE dependencies (ide_{set,get}_dri=
vedata()
>   patch) and there are some other pending IDE changes that will requi=
re minor
>   updates to the patch. ]
>
> Just ping me after platform-specific part is in and I'll push the dri=
ver
> to Linus (of course given that everybody is happy with the final vers=
ion).
>
> Thanks.
> Bart
>  =20

Ok, will do so.

Jo=E3o


--=20
***********************************************************************=
*

    Jo=E3o Ramos        <joao.ramos@inov.pt>

    INOV INESC Inova=E7=E3o - ESTG Leiria
    Escola Superior de Tecnologia e Gest=E3o de Leiria
    Ed=EDficio C1, Campus 2
    Morro do Lena, Alto do Vieiro
    Leiria
    2411-901 Leiria
    Portugal

    Tel: +351244843424
    Fax: +351244843424

***********************************************************************=
*

