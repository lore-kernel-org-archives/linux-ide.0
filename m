From: Tejun Heo <tj@kernel.org>
Subject: Re: Drives missing at boot
Date: Wed, 07 Jul 2010 19:26:22 +0200
Message-ID: <4C34B8BE.5080504@kernel.org>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>	<4C2F5ECB.1040505@kernel.org>	<AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>	<4C2F61AB.9030806@kernel.org>	<AANLkTilYOT45q8OUJ-_V61_fnYy9HIk6GAv5ZPiomCaT@mail.gmail.com>	<4C317C04.20500@kernel.org>	<AANLkTilupyieml9yaWO9BUNPmQQ0g2w1HLWj6R9MwDZf@mail.gmail.com>	<4C32CE50.6010501@kernel.org>	<AANLkTikehTO1j6Gd7Y_g32_P6Yg9KB8Z8qwbNJh10aOU@mail.gmail.com>	<4C341598.6040004@kernel.org>	<AANLkTik4zkcIyVxwtX8GA1BsQSZaAeODpPlY3mRVBc-4@mail.gmail.com>	<4C34A1D5.1090202@kernel.org> <AANLkTilgQSu3qi7qoTtjnV22r-8Sh1hbDAB_nlPImWNt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45832 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615Ab0GGR0Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jul 2010 13:26:24 -0400
In-Reply-To: <AANLkTilgQSu3qi7qoTtjnV22r-8Sh1hbDAB_nlPImWNt@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Knecht <markknecht@gmail.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On 07/07/2010 07:06 PM, Mark Knecht wrote:
> 4 warm reboots. All 4 said 300 300. However the 4th one only showed an
> extra attempt at running the patch code with and also showed Tries =
> 2. I'm attaching boot #1 and boot #4 for now. I've saved them all if
> you need or just want them.
> 
> Please note that in all 4 cases all drives were found. Nothing is
> missing in any test yet after adding these either of these patches.
> 
> I've not tried cold boots yet. That's next.

Hmm... just in case you're being lucky, please keep an eye on it over
several days and report the result.  I think all that's necessary is
slight modification to the resume logic but let's watch a bit first.

Thanks.

-- 
tejun
