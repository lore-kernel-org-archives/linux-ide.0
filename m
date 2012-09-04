From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: RE: [PATCH] sata_fsl: add workaround for data length mismatch on
 freescale V2 controller
Date: Tue, 4 Sep 2012 13:00:28 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB906C13480@GBRSUN01MS002.eu.xerox.net>
References: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Class: urn:content-classes:message
In-Reply-To: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Shaohui Xie <Shaohui.Xie@freescale.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Anju Bhartiya <Anju.Bhartiya@freescale.com>
List-Id: linux-ide@vger.kernel.org

> The freescale V2 SATA controller checks
> if the received data length matches
> the programmed length 'ttl', if not,
> it assumes that this is an error.
...

Can you tell us exactly what
"The freescale V2 SATA controller" is,
and what versions of what devices contain it?

Thanks,
Clive
