From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [1/2] 2.6.23-rc3: known regressions with patches
Date: Wed, 29 Aug 2007 17:28:01 +0200
Message-ID: <46D59081.2040605__4284.36297593198$1188401403$gmane$org@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Gabriel C <nix.or.die@googlemail.com>, Satyam Sharma <satyam.sharma@gmail.com>, Vitaly Bordug <vitb@kernel.crashing.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Tony Luck <tony.luck@intel.com>, John Stultz <johnstul@us.ibm.com>, Paolo Ornati <ornati@fastwebnet.it>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, Stephen Ziemba <sziemba@ecn.purdue.edu>
List-Id: linux-ide@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.23-rc4
with patches available.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            9
Andi Kleen                             5
Linus Torvalds                         5
Andrew Morton                          4
Hugh Dickins                           4
Al Viro                                3
Alan Stern                             3
Cornelia Huck                          3
Jens Axboe                             3
Tejun Heo                              3



Unclassified

Subject         : 8250 claims non existing device blocking IO port
References      : http://lkml.org/lkml/2007/8/18/20
Last known good : ?
Submitter       : Andrey Borzenkov <arvidjaar@mail.ru>
Caused-By       : ?
Handled-By      : Bjorn Helgaas <bjorn.helgaas@hp.com>
Patch           : http://lkml.org/lkml/2007/8/21/291
Status          : patch was suggested

Subject         : Oops while modprobing phy fixed module
References      : http://lkml.org/lkml/2007/7/14/63
Last known good : ?
Submitter       : Gabriel C <nix.or.die@googlemail.com>
Caused-By       : ?
Handled-By      : Satyam Sharma <satyam.sharma@gmail.com>
                  Vitaly Bordug <vitb@kernel.crashing.org>
Patch1          : http://lkml.org/lkml/2007/7/18/506
Status          : patch available



ACPI

Subject         : the fan doesn't work any more
References      : http://lkml.org/lkml/2007/8/28/359
Last known good : ?
Submitter       : Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Caused-By       : Alexey Starikovskiy <astarikovskiy@suse.de>
                  commit cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b
Handled-By      : Alexey Starikovskiy <astarikovskiy@suse.de>
Patch           : http://lkml.org/lkml/2007/8/29/15
Status          : patch was suggested



Clocks & time

Subject         : "double" hpet clocksource && hard freeze
References      : http://lkml.org/lkml/2007/8/23/257
Last known good : ?
Submitter       : Paolo Ornati <ornati@fastwebnet.it>
Caused-By       : Tony Luck <tony.luck@intel.com>
                  commit 0aa366f351d044703e25c8425e508170e80d83b1
Handled-By      : John Stultz <johnstul@us.ibm.com>
                  Tony Luck <tony.luck@intel.com>
Patch           : http://lkml.org/lkml/2007/8/23/285
Status          : patch available



SATA/PATA

Subject         : sata_promise 2.09 fails to identify ST3400832AS
References      : http://bugzilla.kernel.org/show_bug.cgi?id=8936
Last known good : ?
Submitter       : Stephen Ziemba <sziemba@ecn.purdue.edu>
Caused-By       : Mikael Pettersson <mikpe@it.uu.se>
                  commit a77720ad0a4049e4bc6355e4febf899966a48222
Handled-By      : Mikael Pettersson <mikpe@it.uu.se>
Patch           : http://bugzilla.kernel.org/show_bug.cgi?id=8936#c3
Status          : patch available



Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
