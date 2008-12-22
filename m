From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Re: Help interpreting AHCI failure messages
Date: Mon, 22 Dec 2008 09:17:58 +0000
Message-ID: <f4527be0812220117v6fcc72c6v8012247ec443f636@mail.gmail.com>
References: <4942D651.1050306@goop.org> <4943317C.8000807@shaw.ca>
	<49434EC9.4070408@goop.org> <49446DD0.3030600@gmail.com>
	<494BCC08.4070206@goop.org> <494F11FD.1040606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <494F11FD.1040606@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Dec 22, 2008 at 4:05 AM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> Jeremy Fitzhardinge wrote:
>>>> Furthermore, ata2 - which is sharing the same interrupt - seems to have
>>>> managed to read the DVD drive's information, so something must be
>>>> working.  But why is it failing for the disk?
>>>
>>> Can you try irqpoll on it?
>>
>> Here's a log of a run where everything works initially, but then it
>> starts to fail (about half way into the log).  ATA_DEBUG is enabled, so
>> its pretty verbose.
>>
>> http://kraxel.fedorapeople.org/for-jeremy/xeni.log
>>
>> Does anything stand out?
>
> Can you please exclude pata_acpi from the initrd and see whether
> anything changes?

I have already tried using a kernel with pata_acpi disabled, it does not help.

Andy

>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
