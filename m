From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: libata badness
Date: Fri, 1 Aug 2008 07:46:50 -0500
Message-ID: <48592693-41C0-4A71-8678-A0F44457BE47@kernel.crashing.org>
References: <95646AC3-5385-4F59-8EBA-20F811168A87@kernel.crashing.org>
	<20080731210410.GA623@polina.dev.rtsoft.ru>
	<DAE7C7B4-CE5B-45EB-B3B4-E5491A843CD9@kernel.crashing.org>
	<20080801104347.GM26938@trinity.fluff.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080801104347.GM26938@trinity.fluff.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: linux-ide@vger.kernel.org


On Aug 1, 2008, at 5:43 AM, Ben Dooks wrote:

> On Thu, Jul 31, 2008 at 04:58:05PM -0500, Kumar Gala wrote:
>> I figured out the issue.  Its related to the interrupt routing being
>> conveyed to the code from the device tree.  We have a missing 'space'
>> causing issues.
>
> out of interest, is the M5229 attached to a single IRQ in this device
> or has the bridge been configured to route the IRQs from the IDE to
> the same pin on the PIC?

The bridge is routing interrupts via an i8259 to a single interrupt on  
the OpenPIC (primary pic).

- k
