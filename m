From: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Wed, 13 Aug 2008 17:25:59 -0400
Message-ID: <48A35167.6030001@harris.com>
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<48A0676E.5020308@harris.com>
	<20080811170756.GA29827@oksana.dev.rtsoft.ru>
	<1218492032.8041.11.camel@pasglop> <48A19788.6050502@harris.com>
	<20080812140457.GA9103@oksana.dev.rtsoft.ru>
	<48A19BC2.8060008@ru.mvista.com>
	<20080812143110.GA23961@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0794873210=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080812143110.GA23961@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: avorontsov@ru.mvista.com
Cc: "Sparks, Sam" <SSparks@aclaratech.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Stefan Roese <sr@denx.de>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--===============0794873210==
Content-Type: multipart/alternative;
 boundary="------------080306080207010309040200"

This is a multi-part message in MIME format.
--------------080306080207010309040200
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit

Anton Vorontsov wrote:
> On Tue, Aug 12, 2008 at 06:18:42PM +0400, Sergei Shtylyov wrote:
>   
>> Anton Vorontsov wrote:
>>
>>     
>>>>>> 1. IDE status read does not work. (But am I understand correctly
>>>>>>   that IDE works well if IRQ is unspecified? Then this is hardly
>>>>>>   an issue.)
>>>>>> 2. IDE interrupt comes when it should not. I'd recommend to use
>>>>>>   oscilloscope to find out what is happening there, that is, if
>>>>>>   the drive actually deasserts its irq line after status read.
>>>>>>   If so, than this could be a PIC problem.
>>>>>>             
>>>>>> What is the platform on which you're observing the issue, btw?
>>>>>>             
>>>>> Another possibility is that you got the wrong interrupt number
>>>>> in the device-tree...
>>>>>           
>>>>> Ben.
>>>>>           
>>>> The platform is the AMCC Sequoia board.  We've built a little adapter to
>>>> connect a compact flash card to the processor bus.  I believe the
>>>> interrupt selection in the device tree is correct, and I've checked over
>>>> the u-boot settings for the IRQ line (active high, level sensitive). 
>>>>         
>>> IDE IRQs are active-low.
>>>       
>>    Only on the PCI and only in the native mode. Natively, the IDE INTRQ  
>> signal is active-high, rising edge triggering, as on ISA. You seem to 
>> have an invertor somewhere, if it's not a PCI chip...
>>     
>
> Ugh. Right you are, as always. I've just looked into mpc8349emitx
> schematics, there is indeed an inverter on the irq line.
>
> CF in True IDE mode is active-high, sorry.
>   

Ok, just to close this issue, my CF device is now working perfectly. 
Two problems, both my fault.  1) I thought the alternate registers used
the same reg-shift and offset, so the alt_command and alt_status were at
the wrong address, and 2) I was missing a pull-down on the IRQ line -
the sequoia eval board has it in the schematic, but it is marked "not
populated".

    Thanks to all for your comments and help,
    Steve


--------------080306080207010309040200
Content-Type: text/html; charset=windows-1251
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3Dwindows-1251"
 http-equiv=3D"Content-Type">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Anton Vorontsov wrote:
<blockquote cite=3D"mid:20080812143110.GA23961@oksana.dev.rtsoft.ru"
 type=3D"cite">
  <pre wrap=3D"">On Tue, Aug 12, 2008 at 06:18:42PM +0400, Sergei Shtylyo=
v wrote:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">Anton Vorontsov wrote:

    </pre>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre wrap=3D"">1. IDE status read does not work. (But am I un=
derstand correctly
  that IDE works well if IRQ is unspecified? Then this is hardly
  an issue.)
2. IDE interrupt comes when it should not. I'd recommend to use
  oscilloscope to find out what is happening there, that is, if
  the drive actually deasserts its irq line after status read.
  If so, than this could be a PIC problem.
            </pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre wrap=3D"">What is the platform on which you're observing=
 the issue, btw?
            </pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre wrap=3D"">Another possibility is that you got the wrong in=
terrupt number
in the device-tree...
          </pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre wrap=3D"">Ben.
          </pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <pre wrap=3D"">The platform is the AMCC Sequoia board.  We've bui=
lt a little adapter to
connect a compact flash card to the processor bus.  I believe the
interrupt selection in the device tree is correct, and I've checked over
the u-boot settings for the IRQ line (active high, level sensitive).=20
        </pre>
      </blockquote>
    </blockquote>
    <blockquote type=3D"cite">
      <pre wrap=3D"">IDE IRQs are active-low.
      </pre>
    </blockquote>
    <pre wrap=3D"">   Only on the PCI and only in the native mode. Native=
ly, the IDE INTRQ =20
signal is active-high, rising edge triggering, as on ISA. You seem to=20
have an invertor somewhere, if it's not a PCI chip...
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
Ugh. Right you are, as always. I've just looked into mpc8349emitx
schematics, there is indeed an inverter on the irq line.

CF in True IDE mode is active-high, sorry.
  </pre>
</blockquote>
<br>
Ok, just to close this issue, my CF device is now working perfectly.=A0
Two problems, both my fault.=A0 1) I thought the alternate registers used
the same reg-shift and offset, so the alt_command and alt_status were
at the wrong address, and 2) I was missing a pull-down on the IRQ line
- the sequoia eval board has it in the schematic, but it is marked "not
populated".<br>
<br>
=A0=A0=A0 Thanks to all for your comments and help,<br>
=A0=A0=A0 Steve<br>
<br>
</body>
</html>

--------------080306080207010309040200--

--===============0794873210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============0794873210==--
