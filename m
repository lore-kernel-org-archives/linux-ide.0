From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 3/3] ide/at91: use new introduce smc accessor
Date: Fri, 9 Dec 2011 19:40:47 +0100
Message-ID: <20111209184047.GQ23884@game.jcrosoft.org>
References: <20111208150348.GD23884@game.jcrosoft.org>
 <1323357784-17555-3-git-send-email-plagnioj@jcrosoft.com>
 <4EE1EB9B.4080500@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4EE1EB9B.4080500@mvista.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 15:06 Fri 09 Dec     , Sergei Shtylyov wrote:
> Hello.
> 
> On 08-12-2011 19:23, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
>    Same comment about the subject.
> 
> >this will allow to use the pata_at91 on a single zImage
> 
>    s/pata_at91/at91_ide/
> 
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> >Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> >Cc: linux-ide@vger.kernel.org
> >---
> >Hi,
> 
> >	it's depends on other patch for AT91 can we apply via at91
> 
>    I'm afraid David won't accept this, as the IDE tree is frozen for
> anything but the fixes.
basicaly it's a fix on at91 not ide. we can not compile all at91 together because of the
at91_sys_read/write so I need to fix it on at91 this one of the place I need
to touch.

I'll not touch it otherwise

Best Regards,
J.
