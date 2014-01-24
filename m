From: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH V2 3/8] ahci: Add a driver_data field to struct
 ahci_platform_data
Date: Fri, 24 Jan 2014 09:07:54 +0530
Message-ID: <20140124033754.GA2369@pratyush-vbox>
References: <cover.1390471111.git.mohit.kumar@st.com>
 <af75111fb61aebfee6e0233b39dc4cf006906402.1390471111.git.mohit.kumar@st.com>
 <20140123113644.GA28621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140123113644.GA28621@htj.dyndns.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mohit KUMAR DCG <Mohit.KUMAR@st.com>, spear-devel <spear-devel@list.st.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 23, 2014 at 07:36:44PM +0800, Tejun Heo wrote:
> On Thu, Jan 23, 2014 at 04:02:43PM +0530, Mohit Kumar wrote:
> > diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> > index 73a2500..76d35e8 100644
> > --- a/include/linux/ahci_platform.h
> > +++ b/include/linux/ahci_platform.h
> > @@ -28,6 +28,7 @@ struct ahci_platform_data {
> >  	const struct ata_port_info *ata_port_info;
> >  	unsigned int force_port_map;
> >  	unsigned int mask_port_map;
> > +	void *driver_data;
> 
> Please use private_data instead for consistency with other ata data
> structures.

Ok.. ll do that in V3.

Thanks for your review.

Regards
Pratyush
> 
> Thanks.
> 
> -- 
> tejun
