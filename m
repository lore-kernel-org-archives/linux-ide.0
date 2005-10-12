From: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
Date: Wed, 12 Oct 2005 16:57:26 +0100
Message-ID: <434D3266.9000203@gentoo.org>
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751472AbVJLP53@vger.kernel.org>
In-Reply-To: <434D2DF1.9070709@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru
List-Id: linux-ide@vger.kernel.org

Daniel Drake wrote:
> Do you have any suggestions for how I can compute the value of via_clock 
> in userspace? (i.e. some equivalent of system_bus_clock())

Uh, looks like the kernel just assumes 33mhz unless overriden by the user. Is 
this assumption generally accurate?
If it is not, then there's probably no point displaying timing info...

Daniel
