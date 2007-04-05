From: Milan =?iso-8859-2?B?S2VyuWzhZ2Vy?= <milan.kerslager-jPq9pNF91Eg@public.gmane.org>
Subject: Re: sata_mv error recovery issues
Date: Thu, 5 Apr 2007 11:35:11 +0200
Message-ID: <20070405093511.GB7072@opteron.pslib.cz>
References: <20070404132533.GA2339@xi.wantstofly.org>
Reply-To: "The CentOS developers mailing list." <centos-devel-IFYaIzF+flcdnm+yROfE0A@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <centos-devel-bounces-IFYaIzF+flcdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070404132533.GA2339-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <http://lists.centos.org/mailman/listinfo/centos-devel>,
	<mailto:centos-devel-request-IFYaIzF+flcdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.centos.org/pipermail/centos-devel>
List-Post: <mailto:centos-devel-IFYaIzF+flcdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:centos-devel-request-IFYaIzF+flcdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <http://lists.centos.org/mailman/listinfo/centos-devel>,
	<mailto:centos-devel-request-IFYaIzF+flcdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: centos-devel-bounces-IFYaIzF+flcdnm+yROfE0A@public.gmane.org
Errors-To: centos-devel-bounces-IFYaIzF+flcdnm+yROfE0A@public.gmane.org
To: "The CentOS developers mailing list." <centos-devel-IFYaIzF+flcdnm+yROfE0A@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Wed, Apr 04, 2007 at 03:25:33PM +0200, Lennert Buytenhek wrote:
> sata_mv (driving two 8-port Supermicro AOC-SAT2-MV8 PCI-X adapters) in
> 2.6.18-1.2747.el5 (RHEL/CentOS 5 beta kernel) didn't respond too well
> to one of the attached disks experiencing what seems to be a head crash.

Current sata_mv driver has no EH (Error Reporting) code, so this is
expected to hang your machine if HW problem occur, see my bugreport for
more details:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=233211

[a bunch of lines deleted]

-- 
                            Milan Kerslager
                            http://www.pslib.cz/ke/
                            http://www.kai.tul.cz/~kerslage/
