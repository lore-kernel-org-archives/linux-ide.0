From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] 460EX on-chip SATA driver<kernel 2.6.33> < resubmission :
	01>
Date: Wed, 17 Mar 2010 13:03:06 +0100
Message-ID: <201003171303.06258.sr@denx.de>
References: <1268646854-27387-1-git-send-email-rsarmah@appliedmicro.com>
	<AC311A8E81420D4EBC1F26E6479848FE065B7F30@SDCEXCHANGE01.ad.amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <AC311A8E81420D4EBC1F26E6479848FE065B7F30@SDCEXCHANGE01.ad.amcc.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Rupjyoti Sarmah <rupjyoti.sarmah@appliedmicro.com>, linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Rupjyoti Sarmah <rupjyoti.sarmah@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

Hi Rup,

On Wednesday 17 March 2010 05:23:16 Rupjyoti Sarmah wrote:
> This patch enables the on-chip DWC SATA controller of the AppliedMicro
> processor 460EX.

Apart from the other comments, did you take a look at the latest version of 
this driver in our linux-2.6-denx repository? We did some work on this driver 
for a new Canyonlands release last year. It's hard to check this for me now, 
with this line wrapped patch (the drivers diverged somewhat). So either check 
for yourself, or send a new, not line-wrapped, patch version so that I can 
better check myself.

BTW: It would be nice if you would add me to Cc on DWC-SATA related patches, 
since I've been involved in the development at some time.

Thanks.

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
