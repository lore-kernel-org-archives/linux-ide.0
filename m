From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Re: Problems with Samsung SH-W163A SATA CD/DVDRW JMicron 20360/20363 2.6.18.1
Date: Thu, 9 Nov 2006 12:25:44 +0000
Message-ID: <f4527be0611090425r44f77a51i98a831d10a92e13d@mail.gmail.com>
References: <f4527be0611081117x4f7610e1wc4aacbbfdcd6993a@mail.gmail.com>
	 <1163017437.23956.73.camel@localhost.localdomain>
	 <45531E80.7010908@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:47786 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932805AbWKIMZq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 07:25:46 -0500
Received: by ug-out-1314.google.com with SMTP id m3so199131ugc
        for <linux-ide@vger.kernel.org>; Thu, 09 Nov 2006 04:25:44 -0800 (PST)
In-Reply-To: <45531E80.7010908@tmr.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>, linux-ide@vger.kernel.org

On 11/9/06, Bill Davidsen <davidsen@tmr.com> wrote:
> Alan Cox wrote:
>
> >Several people are reporting problems with AHCI and CD burning - are all
> >the people concerned seeing this with Jmicron controllers or with other
> >cases too ?
> >
> Now that you say that, I did have problems in the May-June time frame
> with AHCI. The machine has since been redeployed, but I doubt that it
> was a Jmicron controller, it was whatever Dell was shipping when
> Pentium-II was still in use. I dropped in a new UHCI card and the
> problems went away.
>
> Andrew, I don't know if using another interface is an option for you,
> but it might be useful information if you could try.
>
> --
> bill davidsen <davidsen@tmr.com>
>   CTO TMR Associates, Inc
>   Doing interesting things with small computers since 1979
>
>

The system has sata_piix ports as well, currently all used with hds,
but I can remove them as the boot/os hd is on the jmicron, I will do
that this weekend and report back.

Andy
