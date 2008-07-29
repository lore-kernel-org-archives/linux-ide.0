From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [RFC] [PATCH 2/7] pcmcia: use pcmcia_loop_config in pata and
	ide	drivers
Date: Tue, 29 Jul 2008 15:19:01 -0500
Message-ID: <488F7B35.5040205@lwfinger.net>
References: <20080729071539.GB27385@comet.dominikbrodowski.net>
	<20080729071733.GD27385@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <20080729071733.GD27385@comet.dominikbrodowski.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-pcmcia@lists.infradead.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

Dominik Brodowski wrote:
> Use the config loop helper in pata_pcmcia and ide_cs
> 
> CC: Tejun Heo <htejun@gmail.com>
> CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
> CC: linux-ide@vger.kernel.org
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  drivers/ata/pata_pcmcia.c   |  171 ++++++++++++++++++++-----------------------
>  drivers/ide/legacy/ide-cs.c |  156 +++++++++++++++++++--------------------
>  2 files changed, 155 insertions(+), 172 deletions(-)

ACKed by Larry Finger <Larry.Finger@lwfinger.net> for ide-cs

There was one patch rejection when installing onto 2.6.27-rc1:

>  static int ide_config(struct pcmcia_device *link)
>  {
>      ide_info_t *info = link->priv;
> -    tuple_t tuple;
> -    struct {
> -	u_short		buf[128];
> -	cisparse_t	parse;
> -	config_info_t	conf;
> -	cistpl_cftable_entry_t dflt;
> -    } *stk = NULL;
> -    cistpl_cftable_entry_t *cfg;
> -    int pass, last_ret = 0, last_fn = 0, is_kme = 0;
> +    struct pcmcia_config_check *stk = NULL;
> +    int last_ret = 0, last_fn = 0, is_kme = 0;
>      unsigned long io_base, ctl_base;
>      ide_hwif_t *hwif;

The last line should be

 >      struct ide_host *host;



Larry
