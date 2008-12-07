From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Re: MCP55 disk activity LEDs don't flash
Date: Sun, 7 Dec 2008 14:57:15 +0000
Message-ID: <f4527be0812070657q237924cbq7fe48b35e19c0d6@mail.gmail.com>
References: <493A8767.5030200@seiner.com> <20081206120533.48025219@tuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.176]:14923 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbYLGO5S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 09:57:18 -0500
Received: by ik-out-1112.google.com with SMTP id c29so575631ika.5
        for <linux-ide@vger.kernel.org>; Sun, 07 Dec 2008 06:57:16 -0800 (PST)
In-Reply-To: <20081206120533.48025219@tuna>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Dan_No=E9?= <dpn@isomerica.net>
Cc: Yan Seiner <yan@seiner.com>, linux-ide@vger.kernel.org

On Sat, Dec 6, 2008 at 5:05 PM, Dan No=E9 <dpn@isomerica.net> wrote:
> On Sat, 06 Dec 2008 06:08:39 -0800
> Yan Seiner <yan@seiner.com> wrote:
>
>> I have a 6 slot server case with a backplane.  AFAICT the backplane
>> is passive and there are SATA cables that lead from the backplane to
>> the mobo.
>>
>> The problem is that the disk activity LEDs for the slots don't flash
>> at all.  The mobo is an ASUS M2N SLI Deluxe, which has the MCP55
>> controller.
>>
>> The drive activity LED which plugs into the mobo works just fine; th=
e
>> individual LEDs for each of the drives don't flash - they just stay
>> on. Is there something I can enable to make them work?  Or is the
>> backplane broken?
>
> I have a Tyan Transport GT20 and the individual drive bay LEDs don't
> work at all.  Annoying, but I'm not physically near the system that
> much.  If I recall correctly, on the GT20 the backplane didn't have t=
he
> capability to light the LEDs (although then I don't understand wtf
> there are LEDs there... perhaps Windows has some way of lighting them=
).
>
> Cheers,
> Dan

I have a similar problem with a supermicro system with sc743tq-865-sq
chassis + x7dwa-n motherboard, the chassis has a 8 drive hot swap
backplane but the motherboard only has 6 ports, the 6 drives that are
connected to the m/b have working led's but the 2 remaining drives
only flash when the drives spin up, the activity and status lights
remain off the rest of the time.

I've never figured out how the led's are driven, the backplane does
have two gpio ports which could be connected to gpio on the
motherboard, but I have never used them and it seems to work ok as it
is.

Andy
>
> --
>                    /--------------- - -  -  -   -   -
>                   |  Dan No=E9
>                   |  http://isomerica.net/~dpn/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
