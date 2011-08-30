From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
	different features
Date: Tue, 30 Aug 2011 17:07:28 +0800
Message-ID: <CAMPhdO9ndyAq57ptBKXo1owWLatJaTeOXvEvzoxcfh19h=piBg@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
	<20110829121214.GA15484@oksana.dev.rtsoft.ru>
	<CAMPhdO_XsrGTiiKpALVU7tZiAO_C5d_9XKoVjL_BHwpcqzXcFg@mail.gmail.com>
	<CAJNCFVJKvO+W0ogn-3GOsR8ygtn5KWtqTc2sw6HuNB2-x7ZviA@mail.gmail.com>
	<CAJNCFVKPUW95F0Wt9eVWs0+ne1pdXreYi6uSKH2TkR+Qt_sm4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJNCFVKPUW95F0Wt9eVWs0+ne1pdXreYi6uSKH2TkR+Qt_sm4A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Zhu <richard.zhu@linaro.org>, Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, kernel@pengutronix.de, eric@eukrea.com
List-Id: linux-ide@vger.kernel.org

On Tue, Aug 30, 2011 at 3:07 PM, Richard Zhu <richard.zhu@linaro.org> wrote:
> Hi:
> One more concern, the .../drivers/ata/ahci.h file should be moved to
> .../include/linux/ folder.
> Because that the kinds of macros used in the ata_port_info and the
> ahci_pmp_retry_srst_ops are
> all defined in the .../drivers/ata/ahci.h file.
> Otherwise, the ata_port_info can't be defined in the board related
> platform data.
>
> How we can handle this case?

That's indeed an issue, Anton, what's your suggestion?
