From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 1/2] regulator: core: Add a sanity check on the regulator_
 enable/disable functions
Date: Tue, 06 Jan 2015 12:36:02 +0100
Message-ID: <54ABC8A2.7090905@free-electrons.com>
References: <1419614799-5770-1-git-send-email-gregory.clement@free-electrons.com> <1419614799-5770-2-git-send-email-gregory.clement@free-electrons.com> <20141229154030.GJ17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141229154030.GJ17800@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Mark,

On 29/12/2014 16:40, Mark Brown wrote:
> On Fri, Dec 26, 2014 at 06:26:38PM +0100, Gregory CLEMENT wrote:
>> These two functions use the pointer passed in parameter without any
>> check. By adding a NULL pointer check, it allows using those functions
>> from a driver in a more generic way. It is useful especially for the
>> disable case if the regulator is optional.
> 
> No, especially in the case of regulator_enable() this is deliberate -
> we're trying to ensure that if people are using regulators they're being
> careful about it, checking error codes and so on.  I'd really want to

OK so at least we should check that the pointer is not NULL before using it
and inform the user of it by using a WARNING() or even a BUG() instead of
just let the kernel crash latter.

> see some persuasive use case for this.  What you're saying here sounds
> like the consumer shouldn't be treating the regulator as optional at
> all but should instead be using a normal regulator.
> 

Being able to deal with NULL pointer in the disable function is convenient
and is done in other similar subsystems such as phy or clk for example. Instead
of having a check on the NULL pointer in each driver, it seems more logical to
do it directly in the disable function.

Thanks for you review,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
