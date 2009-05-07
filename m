From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: EP93xx PIO IDE driver proposal
Date: Thu, 7 May 2009 19:58:04 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090172C9EA@mi8nycmail19.Mi8.com>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com> <49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com> <49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com> <4A019BE4.9020903@inov.pt> <4A01C376.8000803@ru.mvista.com> <4A02AB9C.4050107@inov.pt> <BD79186B4FD85F4B8E60E381CAEE19090172C8D6@mi8nycmail19.Mi8.com> <4A035C11.9050505@bluewatersys.com> <BD79186B4FD85F4B8E60E381CAEE19090172C9CC@mi8nycmail19.Mi8.com> <4A0365D5.5020306@bluewatersys.com> <BD79186B4FD85F4B8E60E381CAEE19090172C9E1@mi8nycmail19.Mi8.com> <4A036AE1.5080706@bluewatersys.com> <4A036F95.7050601@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod6ob109.obsmtp.com ([64.18.1.22]:59606 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752278AbZEGX6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 May 2009 19:58:07 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4A036F95.7050601@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>, Ryan Mallon <ryan@bluewatersys.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

On Thursday, May 07, 2009 4:33 PM, Jo=E3o Ramos wrote:
>>>> Yeah, that makes sense. Keeps the driver nice and clean that way
>>>> too.  The ep93xx_ide_on_gpio function for core.c should be posted
>>>> as a separate patch though.
>>>>
>>>>      =20
>>> I agree.  Actually that patch needs to go in now so that the port
>>> E/F/G pins will work for normal GPIO.  The syscon register defaults
>>> at reset with the bits cleared so the boot state has them set for
>>> IDE mode.  That drove me nuts for quite a while...
>>>
>>> If wanted I will put together the necessary patch for this.
>>>    =20
>>
>> That would be good. I think that we should default all of the pins t=
o
>> gpio mode on boot, and then drivers should call into core.c to put p=
ins
>> in alternative function mode where necessary.
>> =20
>
> Hartley, will you handle this then, or do you want me to submit a=20
> separate patch for the renewed 'ep93xx_ide_on_gpio' function?
> I can do this and test it already with the IDE patch to see if it's O=
K.

I just posted the necessary patch.  Please test that with your IDE patc=
h.

Thanks,
Hartley
