From: Mark Lord <kernel@start.ca>
Subject: Re: SATA hdd refuses to reallocate a sector?
Date: Sat, 29 Jun 2013 19:02:14 -0400
Message-ID: <51CF6776.7090206@start.ca>
References: <20130623101940.GA4448@amd.pavel.ucw.cz> <51C76858.4060906@pobox.com> <20130623215100.GA7414@amd.pavel.ucw.cz> <201306240914.29502.linux@rainbow-software.org> <20130629184716.GA9330@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130629184716.GA9330@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Ondrej Zary <linux@rainbow-software.org>, Pavel Machek <pavel@ucw.cz>, Mark Lord <mlord@pobox.com>, Marcus Overhagen <marcus.overhagen@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

On 13-06-29 02:47 PM, Henrique de Moraes Holschuh wrote:
> You know, either the "long" or the "offline" SMART test routines do exactly
> that on any spinning rust device with a firmware that is not utterly broken.
> 
> The HDD's firmware will rewrite, and even reallocate any "weak" sectors
> found by the surface scan.
> 

The drives I have tried this on (smartctl -t long),
abort at the first bad sector.  Not useful.
