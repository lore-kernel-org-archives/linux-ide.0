From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: ide boot failure 2.6.36/2.6.28 - 2.6.27 works
Date: Fri, 19 Nov 2010 18:59:50 -0800
Message-ID: <4CE739A6.6070306@gmail.com>
References: <20101120021515.GA3277@iq>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101120021515.GA3277@iq>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 11/19/2010 06:15 PM, Andries E. Brouwer wrote:
> In case anybody is still interested in this old IDE stuff:
> I wanted to boot a recent kernel on an old machine and failed.
> The last kernel that worked was 2.6.27.
> What goes wrong is that the disks are no longer detected on 2.6.28.
> I see that 2.6.28 had a lot of changes in this area.
> Maybe this just needs a new boot option I overlooked.
> (Or is oldfashioned IDE considered broken these days?)
>
> Google gives me many people with the same problem
> (e.g., http://bugs.gentoo.org/253628) but no remedy.
> I have not looked at the code yet.
>
> Andries
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


probably best to bisect if you can..

Justin P. Mattock
