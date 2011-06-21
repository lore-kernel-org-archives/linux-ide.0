From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata/sas: only set FROZEN flag if new EH is supported
Date: Tue, 21 Jun 2011 16:39:12 -0400
Message-ID: <4E010170.9050901@pobox.com>
References: <20110615191747.GA6324@us.ibm.com>
	<4DF90FCA.1040706@linux.vnet.ibm.com>
	<20110615233417.GB6324@us.ibm.com>
	<20110616075114.GH8141@htj.dyndns.org>
	<4DFA0507.3090609@linux.vnet.ibm.com>
	<20110616152836.GA15268@us.ibm.com>
	<20110621160714.GA14174@us.ibm.com>
	<4E00FF58.7070802@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4E00FF58.7070802@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: wayneb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, mbizon@freebox.fr, Tejun Heo <tj@kernel.org>, Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

On 06/21/2011 04:30 PM, Brian King wrote:
> Looks good to me. Jeff/Tejun - any issues with merging this?

Looks good here too -- though of course we want to move towards purging 
old-EH paths :)

Queued...
