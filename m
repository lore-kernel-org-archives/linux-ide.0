From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] libata:fix kernel panic when hotplug
Date: Wed, 15 Jun 2016 16:24:15 +0800
Message-ID: <201606151601.UeqAVfAa%fengguang.wu@intel.com>
References: <1465976574-18318-1-git-send-email-dingxiang@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465976574-18318-1-git-send-email-dingxiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, tj@kernel.org, linux-ide@vger.kernel.org, fangwei1@huawei.com, miaoxie@huawei.com, wangyijing@huawei.com, zhangaihua1@huawei.com, zhaohongjiang@huawei.com, houtao1@huawei.com, linux-kernel@vger.kernel.org, dingxiang@huawei.com
List-Id: linux-ide@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[auto build test ERROR on tj-libata/for-next]
[also build test ERROR on v4.7-rc3 next-20160615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/DingXiang/libata-fix-kernel-panic-when-hotplug/20160615-154255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/libata for-next
config: tile-allyesconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All error/warnings (new ones prefixed by >>):

   drivers/ata/libata-eh.c: In function 'ata_scsi_port_error_handler':
>> drivers/ata/libata-eh.c:836:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>> drivers/ata/libata-eh.c:836:1: warning: '__used__' attribute ignored [-Wattributes]
>> drivers/ata/libata-eh.c:836:1: error: section attribute cannot be specified for local variables
>> drivers/ata/libata-eh.c:836:1: warning: 'externally_visible' attribute have effect only on public objects [-Wattributes]
>> drivers/ata/libata-eh.c:836:1: error: declaration of '__ksymtab_ata_scsi_port_error_handler' with no linkage follows extern declaration
   drivers/ata/libata-eh.c:836:1: note: previous declaration of '__ksymtab_ata_scsi_port_error_handler' was here
   drivers/ata/libata-eh.c:871:1: error: non-static declaration of 'ata_port_wait_eh' follows static declaration
   drivers/ata/libata-eh.c:847:6: note: previous definition of 'ata_port_wait_eh' was here
   drivers/ata/libata-eh.c:871:1: warning: '__used__' attribute ignored [-Wattributes]
   drivers/ata/libata-eh.c:871:1: error: section attribute cannot be specified for local variables
   drivers/ata/libata-eh.c:871:1: warning: 'externally_visible' attribute have effect only on public objects [-Wattributes]
>> drivers/ata/libata-eh.c:871:1: error: declaration of '__ksymtab_ata_port_wait_eh' with no linkage follows extern declaration
   drivers/ata/libata-eh.c:871:1: note: previous declaration of '__ksymtab_ata_port_wait_eh' was here
   drivers/ata/libata-eh.c:873:12: error: invalid storage class for function 'ata_eh_nr_in_flight'
   drivers/ata/libata-eh.c:937:13: error: invalid storage class for function 'ata_eh_set_pending'
   drivers/ata/libata-eh.c:1012:1: error: non-static declaration of 'ata_std_sched_eh' follows static declaration
   drivers/ata/libata-eh.c:1000:6: note: previous definition of 'ata_std_sched_eh' was here
   drivers/ata/libata-eh.c:1012:1: warning: '__used__' attribute ignored [-Wattributes]
   drivers/ata/libata-eh.c:1012:1: error: section attribute cannot be specified for local variables
   drivers/ata/libata-eh.c:1012:1: warning: 'externally_visible' attribute have effect only on public objects [-Wattributes]
>> drivers/ata/libata-eh.c:1012:1: error: declaration of '__ksymtab_ata_std_sched_eh' with no linkage follows extern declaration
   drivers/ata/libata-eh.c:1012:1: note: previous declaration of '__ksymtab_ata_std_sched_eh' was here
   drivers/ata/libata-eh.c:1032:1: error: non-static declaration of 'ata_std_end_eh' follows static declaration
   drivers/ata/libata-eh.c:1026:6: note: previous definition of 'ata_std_end_eh' was here
   drivers/ata/libata-eh.c:1032:1: warning: '__used__' attribute ignored [-Wattributes]
   drivers/ata/libata-eh.c:1032:1: error: section attribute cannot be specified for local variables
   drivers/ata/libata-eh.c:1032:1: warning: 'externally_visible' attribute have effect only on public objects [-Wattributes]
>> drivers/ata/libata-eh.c:1032:1: error: declaration of '__ksymtab_ata_std_end_eh' with no linkage follows extern declaration
   drivers/ata/libata-eh.c:1032:1: note: previous declaration of '__ksymtab_ata_std_end_eh' was here
   drivers/ata/libata-eh.c:1051:12: error: invalid storage class for function 'ata_do_link_abort'
   drivers/ata/libata-eh.c:1128:13: error: invalid storage class for function '__ata_port_freeze'
   drivers/ata/libata-eh.c:1288:13: error: invalid storage class for function 'ata_eh_scsidone'
   drivers/ata/libata-eh.c:1293:13: error: invalid storage class for function '__ata_eh_qc_complete'
   drivers/ata/libata-eh.c:1471:20: error: invalid storage class for function 'ata_err_string'
   drivers/ata/libata-eh.c:1571:12: error: invalid storage class for function 'ata_eh_read_log_10h'
   drivers/ata/libata-eh.c:1654:13: error: invalid storage class for function 'ata_eh_request_sense'
   drivers/ata/libata-eh.c:1756:13: error: invalid storage class for function 'ata_eh_analyze_serror'
   drivers/ata/libata-eh.c:1885:21: error: invalid storage class for function 'ata_eh_analyze_tf'
   drivers/ata/libata-eh.c:1957:12: error: invalid storage class for function 'ata_eh_categorize_error'
   drivers/ata/libata-eh.c:1991:12: error: invalid storage class for function 'speed_down_verdict_cb'
   drivers/ata/libata-eh.c:2063:21: error: invalid storage class for function 'ata_eh_speed_down_verdict'
   drivers/ata/libata-eh.c:2123:21: error: invalid storage class for function 'ata_eh_speed_down'
   drivers/ata/libata-eh.c:2208:19: error: invalid storage class for function 'ata_eh_worth_retry'
   drivers/ata/libata-eh.c:2230:13: error: invalid storage class for function 'ata_eh_link_autopsy'
   drivers/ata/libata-eh.c:2506:1: error: non-static declaration of 'ata_get_cmd_descript' follows static declaration
   drivers/ata/libata-eh.c:2396:13: note: previous definition of 'ata_get_cmd_descript' was here
   drivers/ata/libata-eh.c:2506:1: warning: '__used__' attribute ignored [-Wattributes]
   drivers/ata/libata-eh.c:2506:1: error: section attribute cannot be specified for local variables
   drivers/ata/libata-eh.c:2506:1: warning: 'externally_visible' attribute have effect only on public objects [-Wattributes]
>> drivers/ata/libata-eh.c:2506:1: error: declaration of '__ksymtab_ata_get_cmd_descript' with no linkage follows extern declaration
   drivers/ata/libata-eh.c:2506:1: note: previous declaration of '__ksymtab_ata_get_cmd_descript' was here
   drivers/ata/libata-eh.c:2517:13: error: invalid storage class for function 'ata_eh_link_report'
   drivers/ata/libata-eh.c:2703:12: error: invalid storage class for function 'ata_do_reset'
   drivers/ata/libata-eh.c:2716:12: error: invalid storage class for function 'ata_eh_followup_srst_needed'
   drivers/ata/libata-eh.c:3117:20: error: invalid storage class for function 'ata_eh_pull_park_action'
   drivers/ata/libata-eh.c:3163:13: error: invalid storage class for function 'ata_eh_park_issue_cmd'
   drivers/ata/libata-eh.c:3191:12: error: invalid storage class for function 'ata_eh_revalidate_and_attach'
   drivers/ata/libata-eh.c:3386:12: error: invalid storage class for function 'atapi_eh_clear_ua'
   drivers/ata/libata-eh.c:3437:12: error: invalid storage class for function 'ata_eh_maybe_retry_flush'
   drivers/ata/libata-eh.c:3513:12: error: invalid storage class for function 'ata_eh_set_lpm'
   drivers/ata/libata-eh.c:3639:12: error: invalid storage class for function 'ata_link_nr_vacant'
   drivers/ata/libata-eh.c:3650:12: error: invalid storage class for function 'ata_eh_skip_recovery'
   drivers/ata/libata-eh.c:3683:12: error: invalid storage class for function 'ata_count_probe_trials_cb'
   drivers/ata/libata-eh.c:3697:12: error: invalid storage class for function 'ata_eh_schedule_probe'
   drivers/ata/libata-eh.c:3746:12: error: invalid storage class for function 'ata_eh_handle_dev_fail'
   drivers/ata/libata-eh.c:4140:1: error: expected declaration or statement at end of input
   drivers/ata/libata-eh.c: At top level:
   drivers/ata/libata-eh.c:166:13: warning: '__ata_port_freeze' used but never defined [enabled by default]

vim +836 drivers/ata/libata-eh.c

c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   830  	/* tell wait_eh that we're done */
b51e9e5db drivers/scsi/libata-eh.c Tejun Heo       2006-06-29   831  	ap->pflags &= ~ATA_PFLAG_EH_IN_PROGRESS;
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   832  	wake_up_all(&ap->eh_wait_q);
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   833  
e30349d27 drivers/scsi/libata-eh.c Tejun Heo       2006-07-03   834  	spin_unlock_irqrestore(ap->lock, flags);
ece1d6361 drivers/scsi/libata-eh.c Tejun Heo       2006-04-02   835  }
0e0b494ca drivers/ata/libata-eh.c  James Bottomley 2011-01-23  @836  EXPORT_SYMBOL_GPL(ata_scsi_port_error_handler);
ece1d6361 drivers/scsi/libata-eh.c Tejun Heo       2006-04-02   837  
ece1d6361 drivers/scsi/libata-eh.c Tejun Heo       2006-04-02   838  /**
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   839   *	ata_port_wait_eh - Wait for the currently pending EH to complete
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   840   *	@ap: Port to wait EH for
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   841   *
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   842   *	Wait until the currently pending EH is complete.
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   843   *
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   844   *	LOCKING:
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   845   *	Kernel thread context (may sleep).
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   846   */
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   847  void ata_port_wait_eh(struct ata_port *ap)
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   848  {
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   849  	unsigned long flags;
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   850  	DEFINE_WAIT(wait);
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   851  
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   852   retry:
ba6a13083 drivers/scsi/libata-eh.c Jeff Garzik     2006-06-22   853  	spin_lock_irqsave(ap->lock, flags);
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   854  
b51e9e5db drivers/scsi/libata-eh.c Tejun Heo       2006-06-29   855  	while (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   856  		prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
ba6a13083 drivers/scsi/libata-eh.c Jeff Garzik     2006-06-22   857  		spin_unlock_irqrestore(ap->lock, flags);
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   858  		schedule();
ba6a13083 drivers/scsi/libata-eh.c Jeff Garzik     2006-06-22   859  		spin_lock_irqsave(ap->lock, flags);
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   860  	}
0a1b622ef drivers/scsi/libata-eh.c Tejun Heo       2006-06-11   861  	finish_wait(&ap->eh_wait_q, &wait);
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   862  
ba6a13083 drivers/scsi/libata-eh.c Jeff Garzik     2006-06-22   863  	spin_unlock_irqrestore(ap->lock, flags);
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   864  
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   865  	/* make sure SCSI EH is complete */
cca3974e4 drivers/ata/libata-eh.c  Jeff Garzik     2006-08-24   866  	if (scsi_host_in_recovery(ap->scsi_host)) {
97750cebb drivers/ata/libata-eh.c  Tejun Heo       2010-09-06   867  		ata_msleep(ap, 10);
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   868  		goto retry;
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   869  	}
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   870  }
81c757bc6 drivers/ata/libata-eh.c  Dan Williams    2011-12-02  @871  EXPORT_SYMBOL_GPL(ata_port_wait_eh);
c6cf9e99d drivers/scsi/libata-eh.c Tejun Heo       2006-05-31   872  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   873  static int ata_eh_nr_in_flight(struct ata_port *ap)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   874  {
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   875  	unsigned int tag;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   876  	int nr = 0;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   877  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   878  	/* count only non-internal commands */
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   879  	for (tag = 0; tag < ATA_MAX_QUEUE - 1; tag++)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   880  		if (ata_qc_from_tag(ap, tag))
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   881  			nr++;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   882  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   883  	return nr;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   884  }
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   885  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   886  void ata_eh_fastdrain_timerfn(unsigned long arg)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   887  {
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   888  	struct ata_port *ap = (void *)arg;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   889  	unsigned long flags;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   890  	int cnt;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   891  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   892  	spin_lock_irqsave(ap->lock, flags);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   893  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   894  	cnt = ata_eh_nr_in_flight(ap);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   895  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   896  	/* are we done? */
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   897  	if (!cnt)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   898  		goto out_unlock;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   899  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   900  	if (cnt == ap->fastdrain_cnt) {
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   901  		unsigned int tag;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   902  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   903  		/* No progress during the last interval, tag all
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   904  		 * in-flight qcs as timed out and freeze the port.
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   905  		 */
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   906  		for (tag = 0; tag < ATA_MAX_QUEUE - 1; tag++) {
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   907  			struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   908  			if (qc)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   909  				qc->err_mask |= AC_ERR_TIMEOUT;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   910  		}
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   911  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   912  		ata_port_freeze(ap);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   913  	} else {
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   914  		/* some qcs have finished, give it another chance */
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   915  		ap->fastdrain_cnt = cnt;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   916  		ap->fastdrain_timer.expires =
341c2c958 drivers/ata/libata-eh.c  Tejun Heo       2008-05-20   917  			ata_deadline(jiffies, ATA_EH_FASTDRAIN_INTERVAL);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   918  		add_timer(&ap->fastdrain_timer);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   919  	}
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   920  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   921   out_unlock:
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   922  	spin_unlock_irqrestore(ap->lock, flags);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   923  }
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   924  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   925  /**
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   926   *	ata_eh_set_pending - set ATA_PFLAG_EH_PENDING and activate fast drain
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   927   *	@ap: target ATA port
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   928   *	@fastdrain: activate fast drain
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   929   *
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   930   *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   931   *	is non-zero and EH wasn't pending before.  Fast drain ensures
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   932   *	that EH kicks in in timely manner.
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   933   *
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   934   *	LOCKING:
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   935   *	spin_lock_irqsave(host lock)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   936   */
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   937  static void ata_eh_set_pending(struct ata_port *ap, int fastdrain)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   938  {
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   939  	int cnt;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   940  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   941  	/* already scheduled? */
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   942  	if (ap->pflags & ATA_PFLAG_EH_PENDING)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   943  		return;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   944  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   945  	ap->pflags |= ATA_PFLAG_EH_PENDING;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   946  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   947  	if (!fastdrain)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   948  		return;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   949  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   950  	/* do we have in-flight qcs? */
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   951  	cnt = ata_eh_nr_in_flight(ap);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   952  	if (!cnt)
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   953  		return;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   954  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   955  	/* activate fast drain */
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   956  	ap->fastdrain_cnt = cnt;
341c2c958 drivers/ata/libata-eh.c  Tejun Heo       2008-05-20   957  	ap->fastdrain_timer.expires =
341c2c958 drivers/ata/libata-eh.c  Tejun Heo       2008-05-20   958  		ata_deadline(jiffies, ATA_EH_FASTDRAIN_INTERVAL);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   959  	add_timer(&ap->fastdrain_timer);
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   960  }
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   961  
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   962  /**
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   963   *	ata_qc_schedule_eh - schedule qc for error handling
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   964   *	@qc: command to schedule error handling for
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   965   *
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   966   *	Schedule error handling for @qc.  EH will kick in as soon as
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   967   *	other commands are drained.
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   968   *
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   969   *	LOCKING:
cca3974e4 drivers/ata/libata-eh.c  Jeff Garzik     2006-08-24   970   *	spin_lock_irqsave(host lock)
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   971   */
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   972  void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   973  {
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   974  	struct ata_port *ap = qc->ap;
fa41efdae drivers/ata/libata-eh.c  Tejun Heo       2010-04-15   975  	struct request_queue *q = qc->scsicmd->device->request_queue;
fa41efdae drivers/ata/libata-eh.c  Tejun Heo       2010-04-15   976  	unsigned long flags;
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   977  
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   978  	WARN_ON(!ap->ops->error_handler);
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   979  
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   980  	qc->flags |= ATA_QCFLAG_FAILED;
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16   981  	ata_eh_set_pending(ap, 1);
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   982  
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   983  	/* The following will fail if timeout has already expired.
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   984  	 * ata_scsi_error() takes care of such scmds on EH entry.
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   985  	 * Note that ATA_QCFLAG_FAILED is unconditionally set after
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   986  	 * this function completes.
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   987  	 */
fa41efdae drivers/ata/libata-eh.c  Tejun Heo       2010-04-15   988  	spin_lock_irqsave(q->queue_lock, flags);
242f9dcb8 drivers/ata/libata-eh.c  Jens Axboe      2008-09-14   989  	blk_abort_request(qc->scsicmd->request);
fa41efdae drivers/ata/libata-eh.c  Tejun Heo       2010-04-15   990  	spin_unlock_irqrestore(q->queue_lock, flags);
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   991  }
f686bcb80 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   992  
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   993  /**
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21   994   * ata_std_sched_eh - non-libsas ata_ports issue eh with this common routine
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   995   * @ap: ATA port to schedule EH for
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   996   *
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21   997   *	LOCKING: inherited from ata_port_schedule_eh
cca3974e4 drivers/ata/libata-eh.c  Jeff Garzik     2006-08-24   998   *	spin_lock_irqsave(host lock)
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15   999   */
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1000  void ata_std_sched_eh(struct ata_port *ap)
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15  1001  {
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15  1002  	WARN_ON(!ap->ops->error_handler);
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15  1003  
f4d6d0046 drivers/ata/libata-eh.c  Tejun Heo       2007-05-01  1004  	if (ap->pflags & ATA_PFLAG_INITIALIZING)
f4d6d0046 drivers/ata/libata-eh.c  Tejun Heo       2007-05-01  1005  		return;
f4d6d0046 drivers/ata/libata-eh.c  Tejun Heo       2007-05-01  1006  
5ddf24c5e drivers/ata/libata-eh.c  Tejun Heo       2007-07-16  1007  	ata_eh_set_pending(ap, 1);
cca3974e4 drivers/ata/libata-eh.c  Jeff Garzik     2006-08-24  1008  	scsi_schedule_eh(ap->scsi_host);
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15  1009  
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15  1010  	DPRINTK("port EH scheduled\n");
7b70fc039 drivers/scsi/libata-eh.c Tejun Heo       2006-05-15  1011  }
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21 @1012  EXPORT_SYMBOL_GPL(ata_std_sched_eh);
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1013  
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1014  /**
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1015   * ata_std_end_eh - non-libsas ata_ports complete eh with this common routine
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1016   * @ap: ATA port to end EH for
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1017   *
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1018   * In the libata object model there is a 1:1 mapping of ata_port to
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1019   * shost, so host fields can be directly manipulated under ap->lock, in
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1020   * the libsas case we need to hold a lock at the ha->level to coordinate
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1021   * these events.
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1022   *
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1023   *	LOCKING:
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1024   *	spin_lock_irqsave(host lock)
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1025   */
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1026  void ata_std_end_eh(struct ata_port *ap)
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1027  {
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1028  	struct Scsi_Host *host = ap->scsi_host;
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1029  
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1030  	host->host_eh_scheduled = 0;
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1031  }
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21 @1032  EXPORT_SYMBOL(ata_std_end_eh);
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1033  
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1034  
e4a9c3732 drivers/ata/libata-eh.c  Dan Williams    2012-06-21  1035  /**

:::::: The code at line 836 was first introduced by commit
:::::: 0e0b494ca8c54a7297d0cc549405091019b3b77e libata: separate error handler into usable components

:::::: TO: James Bottomley <James.Bottomley@suse.de>
:::::: CC: Jeff Garzik <jgarzik@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--vkogqOf2sHV7VnPd
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICL4PYVcAAy5jb25maWcAlFxbc9y2kn4/v2LK2YfdhxPbsjMnu1t6AElwiAxvIsDRSC8s
WR7bqsiSVxplk3+/3eCtATRH2VSlLH5fA8Sl0ehugPPTP35aiZfj4/eb493tzf39X6uvh4fD
083x8Hn15e7+8N+rpFqVlVnJRJmfQTi/e3j58+0RqNXHn9c/v1ttD08Ph/tV/Pjw5e7rC5S8
e3z4x0//iKsyVZvOqFye/zU+FUU7P2xkKRsVd7FuixnNxE52oomzTuR5FXeNLETt0Vqatu5q
2XRx3YKwFLNAKWUyUbXYyC5VjTZdnLXldhbTV7rTbV1XjdFd1m6kyaNUk/f0EMpAXViPDltu
VCG7HVQVQ1tnutWyq4t4BppLLYuplK5VCT0jjbHdnVpT1VCvuoZugJwqVbnxJOsMGi+SpOlM
t/4YKePxSSEWaDs4SMOYdtoII72imdCWhxHu4iqTjSwNCGvSWGx6IuuxvWRIjYi3phGxDLm+
XUrDo1GbAkZDliLK/dc7EolMRZuTSvq6VXOR5mKjmQYUVFF2sad8+LTZw/NPK4LUTbW6e149
PB5Xz4fjKMsOq0z7x/M3N0+33+waeHtr1f7ZPnz9s/t8+NIjb8ai9cZgR7tc7mSuzz+M+FRb
lyttzt+8vb/79Pb74+eX+8Pz239rSwGq1chcCi3f/uzVCf9o07SxqRqilTAw3WXV4FTB+vtp
tbEL+R679fJjXpGgUQZGfwedwncX0M8PZ1PNTaU11F/UOHRvyBst0hmpjaMKIt/JRquqJMIU
7kRrqrnEMKddVmmDXTx/8+8Pjw+H/5jK6ku62mFp7VQdBwD+Gxuy5OpKq31XXLSylTwaFOm7
CopWNVedMKC82UymmSgTqjywpnMVEY1oE6sgdqRh5FfPL5+e/3o+Hr7PIz0ueJwYULNIhhYE
KZ1VlzwD+iriq8EQZpcAhXK1LBMwER1LYiVxpmpXSZKqEKoMpQut3GpmYZi4qCV2SNei0ZJ/
aYwWArS9NHocIHP3/fD0zI2RUfG2q0oJg0DtVNVl16h0RVXSBQsgmGNVJSpmFm1fSvXzNpXp
0bTN86UixGioTQarTlvL3kzNh63krbl5/n11hH6sbh4+r56PN8fn1c3t7ePLw/Hu4avXIbst
xXHVgi2z5ntqzU41xqNx4JimRTpBrYklaCkIk9HxmW73gVg5MNZo2bULwQTm4sqryBJ7BlOV
23w7Ck3crjQzg40ESxWTjR0eOrmHiaK22ZGwjQwLQbvzfJ52wqSirFpzvv4YgrBKRHr+fu0y
sON7czu2s99G3Oq3JgMnAkdVVefvKFNWcYTz5cqPKPxROsrmkNfS3Vt4KeEqpiOEowh2RnZR
BS4YoyOtypMuUuUZsZFqO2xTAWK1hppvrCEFA6RSc/7+XxTHlhViT/lpkygL5ZedtrV401Rt
TZTPumBWlWRDHEFZxBvv0bP9Mzb4CglZAfl2eBPdWsBCsUz/3F02MJKRoI7XwOg4o7WnQjUd
y8Sp7iLYGS5VYshuAUuaF+/RWiU6AFNQx2s6JAM+OJ4Er2HvocsZJxHrHJighkTuVOxo5UCA
PK51Ro/GhsomZapzLD/0MN7WlQK/EAwleCBkKeGODjtDTH3lFjzaknopsHvTZ+hC4wDYM/pc
gitKn+0YW7fCm2bY4GF6wDVtZAyebbLMdLszMnloGF3VghG0blJD6rDPooB6dNU2MXWOmqTb
XNNNFoAIgDMHya8L4QD7a4+vvOePZNTjKSzo0qqxM1U1hSi9ifbENPzBTLfvCoEdLaGDVUIn
rhcCExRLqBIEPLsZ1URXfHNfgJOncGpJfaDXGEl0QbzUTw8HYwMCfAtP+qrQIdL1ctNwzHik
q7wFOwqthFXA2ttJOAKX22qFUTtu9GCTKA0xIv0zWkUyOHTJyDwFC0gXin0FuiTE6EDz9qRM
XTljoTalyFOij9ZDoYD1uCgAE8QMagZ2lcy8Ikonkp3ScizjrVHrt9Pq61h1F61qtkQQ6o5E
0yg67wDJJKHL0cbwqMHd5CWOdSKI4fOusE7v6HoMOYb68PTl8en7zcPtYSX/ODyACybAGYvR
CQP/cvZJ2Mr7DYJ5xeiaFX2RcbeiayFvo8AQQkgkTBfZgGvSIp2LiFtxUIErVi2JDYmLxijh
LgaDMbEwooPQSqUKLJmibhJsC6nKnWyBXbHWVtPFIvcy9vRxa8MTIvRbW9QddEXSJoBXCe79
VmLqBHR6iAWnPrV9JUy37ITbkBpWKGgy2u8Y3VfSgkYavxG2WNC0Hl0Sd1bhnEuyI5FV1dYj
baqkVv7czgW5gRgyJf3bOi1ScHCKeh9nbA1axqgqHUyO4wIFOLXiNpcCHTQSg/ylIYW/wWgY
27utM/OWXog1yHKtkjaHaAeXAxopNHpeHXIPk9Z7x04Tre/byRT0UOGaSVNn4vsERFzt/vnp
5vnwefV7v4B/PD1+ubt34iUUAp1qSumY7ikbZflet6XvK9Mq7HZorF+QSBw2WhuV+NB9ZO0/
lfnY/YuVsUMyxrmoO2OOjF3LAhzzlG7qBvZFmDCqtHYn0GiK5rhjmBZ/nrBxsQTPWyQB1ZYs
3JdgyCE7E74D4rQpc0P3jZGmYcWM9S9imYVaYCMS7+kUudTZGT9JntQv678h9eHXv1PXL+/P
mEkkMqCM2fmb52837994LC7jxrFmHjG6h/6rJ35/vfhu3QeuOdgu6uxGbgZ59FojvWFBJ3c1
u7hGbiAoYrxfWPGVMe5uYkOrIgFQdjb904zbc33zdLzDvP/K/PXjQPdh3Mas8wi+BTqrRAsF
bEHlLLFIdHELfq5Y5qXU1X6ZVrFeJkWSnmDr6hK8WhkvSzRKx4q+XO25LlU6ZXtaqI1gCSMa
xRGFiFlYJ5XmCEwVJUpvvR2sgGhm3+k2YoqApwwvB538dc3V2ELJS9FIrto8KbgiCPv5ww3b
PXAxG34EdcvqylaAveYImbIvwPzx+leOIZodDCKutcHfG1VeVSt9++2A6XrqeKqqD0/LqqJJ
1wFNYBfFl4RMnJJEKjwM+YSBpqZjzKCPdTGGYxTpKw1KYttOlBrf+eb2y//MpxgCPU+ioLp8
7+hEaQcPj7bsdrN8uiVMVcDm2RQk5z3nQoZsMQzqzT+ffxxu777c3a5u+aPF0p7xaUwKTn20
2SaMerv36y3nYc8C649bxyXPrrv3795xrtZ1d/bLO0/0gyvq1cJXcw7VTIpopz1rMF3s+eZ+
iBG4jK46Y0JlEpzboTYY6THtuK5K6/dSJSyKtstkXlP/1J4V6o11c3JZbmjCS1+qyklSlS2t
0GYShtTglDWkZ3tk6iHMtvIYO3bOUa9tgE0k1LBXjtkJ1xfDvCgWREfLinCOWJ2DD1ubfhWj
xkxZ5OH0J8JI0FnxPdCPa+wZCgYDO9744djyIW0Ezjj1lmxHexC2nIoYVOvBm6qLWupcFOh7
GwgB6XRtNRnVcS0XeM4Lxt425Pzju/+csuRxLmE/FqCFdBnC/LhJ2Gvv0W3eddSSDf36Q1rl
9Fn7EfZ4Fgqtqh3XYhS1MSZRzCSX/YoNI5y0wRPSnY2PaBAsZVGbIC8/4rsqh0BINFfs4h2k
2JxPX97GUeGmETnDMqD0+HSQq8C3blRCxnzIQmAuVTY7ef7uz7N39r85CmuSSzf/ZYOlrs7n
tYUH2d1mT5M5E+Su9RkualVLjjANX0+rI3tuy3KimbbG6OV59fgDbTX1BGMSl2PqqD9XdFY0
BJRgilyj5ZK4haD2MDNk24IV08bDs8QyzvrJKlPnbd8KFHDFBV1UCHQybuJABizOb5Kem1lc
10WI+L4PwccLDrMGjpx1PbVwE5CM2JwH5rQWm5/UbuvRmCwYJmQL7U9U0HpQ1l5p+3MZ74gf
BbRpIxdxDiT7adq5QN14L66FVgk7bfxcxouMzuoplQjPq2+Pz0f0Ko5Pj/fgaqw+P9394eYP
7cBdwhoT3hQD6uk/LIuxbvnn4fblePPp/mDvTq1ssvJI6sWEQGEw1+Jv8iwFD26eDp+6BFNS
o4XHtE0GrqCTrhzq0nGjatcrsFmpqmXPEvtCBWzT7gvxfXSzMkHbAQPztoXtVGv3phQe3oDZ
dqNjBOWI2YErD8f/fXz6/e7hK2M5wPLTd/bP4E4IopUYlbhPnsA+bQr3qRP5pvIg98TCQhAk
wWLMVXzlEf2eL31xTJJq4wSdlgA3rfLGEVOpARDWq5whV3XvE8VCu+gYYXcQOTiJRoU5xgjN
uuy8mwFjZehg2a3Z5WxNg4Sg/t/EwX4WVVoyTJwL7axfYOqy9p+7JItDEN26EG1E4w2gqlWA
bHCJyKLd+0Rn2rKk4eokz1URNZVIgkEubOcY6OQ41qrQRbd7z4HkkFBfocdZbVWwguqdUS7U
Jnx/0qoNgLnv2tWqTmQeIHXtIb7eWtBqtP96y7Bgv17QyQc/rtTurT1f4nQFkZR+WXeh962I
aw7GQWNghEBltGkqsh6xDvhzw6SuJipSMYPGLY9fwisuq4qrKDN0FcywXsCvIpqpn/Cd3AjN
4Hig5163nKicq38ny4qBryRVmAlWOVj/SnEvTmK+A3Hi3Ioad7OIvdc15TOGcQ2K4eixftIk
gON1UsKO3CsSJX+bZxQYp/ekkB2QkxIwNCf5xmuHR49DfP7m9uXT3e0bOvRF8ouTwAe7snaf
hs0D452UYzr3RMMS/Y0D3PO6RCTu2loHJmYd2ph1aGSw3kLVfusU1fq+6KIpWi+grxqj9SvW
aH3SHFHWDtlwIcNLD9juOFbdIlqZEOnWzkUUREvMptiEh7mqpUcGjUbQ2eb68V3esfC9bYQH
Dz4cboAT+EqF4X6HbqObQAYEbzBjoqsQzdYhutrUg1eRXoVF6uzK3okAD6dwkwsg4Z+9TpAf
3cxEaPUjiNw30qmuvx36+HRADxZc/iMEEwsfQsw1c/7wQA2O9AnKu8EZ8t4V6FAgr2h/8WZK
Wdr0ioPaO4DeRUwq3HnzQ6lw9iiL+Ue9wOHVtnSJ9O9zOCROPd4QXWatYizwVg29qg22xlRg
seOaZ1zPkRA6NgtFwAPJlZELzRAQyCdigUz9Oicm+3D2YYFSNHXhMIx/6/CgLpGq3Lt77iyX
i8NZ14tt1aJc6r1WS4VM0HfDLBUK8/ow02Gy218mm7yFIMatoBTBs03eUisxwAu6M1OcJsxs
oEFIMeqBsD84iPnzjpg/vogFI4sghPyqkbyZgRgFWri/cgr59n6CvNh1xgFO5I4yEHvsTZY0
LlZII1zEnRJorN2mXMwe1bul/AvICHqW0Axfw7gNEPrCeyGOjgt5emECI2yLufnCGQsGyQQH
PzBwSVuzo7aEp5dJiE/TuJ+mzG5he5u0el7dPn7/dPdw+LwaPkTitq+98W0/pXDRnqD7+8rO
O483T18Px6VXGdFsMFAdPrc5IWIvJjufErJSnAMRSp3uBZHiPJVQ8JWmJzquT0tk+Sv8643A
wxR7afS0mHPPnhWoWH9pFjjRFHehMGVLvCP8yliU6atNKNNFN4gIVb7bwwhhKs755o0VOmEw
ZykjX2mQ8S0rJ+NewuZE/pZKQjhY8D6oIwPBizaN3TicRfv95nj77YR9MPj9bpI0bnTCCDm3
yBne/5aDE8lbveDdzzLgyspyaYJGmbKMroxcGpVZKoxaWClvN+GlTkzVLHRKUQepuj3Je54I
IyB3rw/1CUPVC8i4PM3r0+Vx53593Ja9t1nk9Pww2fhQpBHl5rT2QmB7WlvyM3P6Lf7NCk7k
1fEoRPwK/4qO9ZG7kwlhpMp0KficRCp9ejlXl+UrE+eftXAi2ZVe9GtGma151fZctJXjXYYS
p63/ICNFvuR0jBLxa7bH8/cZgco9BeNE3O/5FyRsou4VqYbPn8wiJ3ePQQRcjZMC7QeSClJ1
p71TLm1dif352S9rD40UOgmd81mzxzgrwiW9hF/Pod3hKhxwdwG53Kn6kFuuFdmS6bWluR5Y
AkqcLHiKOMUt9wNIlTpux8DiLxcE87bT3mOQZkbMy7v1IAQlOEsavzXtb1mCfV0dn24enn88
Ph3x84Hj4+3j/er+8ebz6tPN/c3DLZ4ZP7/8QJ5cw7TV9aG08c4XJwIicJ4Q3j5FuUVCZDw+
rOy5O8/jtVG/uU3j13AZQnkcCIWQm6JHpNqlQU1RWBCx4JVJ0DMdIjLxofLC6bbOlnsOOjZN
/a+kzM2PH/d3tzaRuvp2uP8RlkxNMB1lGvsK2dVyyH4Mdf/X38jXpnik0gibvSZfYrrptWXK
fqXLxPFjYsQrifEr/s7CcMoSsGOqICAw/g+aMbzEPS9PeVnM9PqCiAWCC03o800L3eE4C2Je
pZWNSLjOIsmOAYRZfHWYjMRvaVSY9uJztZbx05QIuslUUB/AVc0c6gM+xDkZjzu+MCWa2j+P
oKwxuU/w4lPw6SaWHDJM1/W0E4g7JeaJWRDwQ3SvMX4kPHat3ORLNQ4BnFqqlBnIMUINx6oR
lz4EAXHrfubS46D1/LyKpRkCYu7KYEv+WP9/rcnaUTrHmrjUbCvW3OKabMXaXyfjQvWIYf27
L2HBhSpGw7AOls1SGzmOMQBe2dEABB0bDIDjTqyXluh6aY0SQrZq/XGBw/laoDAvskBl+QKB
7e6v6i0IFEuN5NSR0iYgmLThwCzUtGhMKMtZkzW/vNfMWlwvLcY1Y5Loe3mbRCXKesorJzJ+
OBz/xpoEwdLmCmFzEFGbC+cm+bz8+nNfVxOHs+DweGIgwmx//4spXlXjkXLaycjX34EDAs/q
nEN3QplgQh3SGVTC/PrurPvAMqKonI/+CEOdBIKrJXjN4l46gzBulEWIIJgnnDb863e5KJe6
0cg6v2LJZGnAsG0dT4V7Hm3eUoVODpvgXnYb9h03ddffWIvnC2690gOwimOVPC9p+1BRh0Jn
TPg1kR8W4KUyJm3izvm+1GHGUnMzhx9zyG5uf3e+BB+LhVcyLO79ghqGoH7SxCKeHEJdEm26
KvotplmYnhgvXdlrl3iMEuMtqXP6Uw1LcvgFM3tTa7EEfpXCfaCE8mELltjhy2mqD/0bnZuN
Df3NIXiA/93fn9FuZIyAN/LG+ek9fAKDB2/p6GQT2AmohSmcB/DyVB0i9ruOuPCY3LklgEhR
V8JFouZs/etHDgPd8I2im4fFp76z9LKJRelPqVlA+eWk8yEcrXbjWMgiNJfBglcbCFs0fpCp
GKOLJmww7+GPO9hlod30JQt02aV7i2eAjcAXxQXPSLYqZMBXVTkdW9tM2FDeX3BYt9nRgSBE
4RD9buw/B5fZc5q0gAcnh7h3Huz37Y37VXW+pW/YdaKuc+nCqk7cxBA8drKMacyzPyMLNBc1
/dglq5x+rPPqsqZb0QCE+jcSZRazoL2izDPoqbrnW5TN6LfIlHA9acoUVaRyx0ujLE6Ko5GU
dKzASGyAwF8qyZKGb87mVEk0EFxLaa384FAJ153nJPy7jVJKVNVfPnJYV+bDH/bHrxSOP/3F
HiLpJ+8JFagHWHj/nb2F778Dt9voxcvh5QB759vhE3RnGx2kuzi6CKroMhMxYKrjEHUM+AjW
zreBI2qPj5i3Nd5dAgvqlGmCTpniRl7kDBqlIbhhX5Xo8BYp4vCvZDqXNA3Ttwu+z3FWbWUI
X3AdiavE/04D4fRimWFmKWP6XSumDewHV1Y6n12x+P7m+Rk/rw/vqcLG7BUGIMiuDbCJVZnI
fUjYxfQxxNPLEHPOggbA/zXCAQ1n1L5M72oeXTMtyCumDcxNg77f3g2FqQrvILOTNhrnsP7n
nMjPLBMq9j8KG3B7FYFlnMEiuBeM/h9j19Yct42s/8rUPpxKqtYnc9GMZh78AILkDCLeRHAu
8gtLK09iVWTZJSknzr8/aIDkdDdAZV0lS/y6CYC4NhqN7gsBfEQFCVIUKg5SVKXZaaP9bMGO
fwFwJ7aJj28J91Y4I9jIZ8xV7Q1fYbVPgdy4CZErQsLNwyysFa9ci95EYXbJrccsSjeSPer1
CptAyJ7DfUrKL5mlCRTE5+4I/qQD9W+GWmCyUPi8J5aohuNCw83yErxxI/HSTO3CuuQJYf2f
I0R8AwPhMdnmXvBCBuGcWh7jhOgepKyS4qCPiowsBFLFPiYcTqThyDtJkRzwJXy3QNNJz1oB
0z1VXvGJEZB2q0vK4wtIFjX9md3M2Gm+4tgCcuOGNluADszdV0Ck27qp6VOrc9RDauyIt06t
t2ic/QnTtXWP0fl8Jc5eOhAKQrslInjXPa3wDv6D9V1LfVlGfFWHyXRQC+H7wJO38+ubJ9xU
Nw3xYlc4UzW277dblrqsjChbKKLZ24m8FrH9js571cMf57dJff/58dtwxIxM2wSR9uHJ1A/E
SMjEgWZYl2j+qN29WJuFOP3vfDl57r7q8/n/Hh/O/q3z/EbhVXtVEaOvqLo1W086ju9kmbfg
QDeNT0F8F8ArgdK4E6jIEg8Y80AVuABEkrK32+MgUIhiErsvi/mXAefBS11nHkS6NwBSZBIO
huEOFR5QQMsS4lcZJpBmM2Plq708fhXFJ7OlEMWCFWdfXBEXBDu/QuQIZD0FgCeGIA37JbCw
vL6eBqBW4U33BQ4nrlIFv7FPVoBzv4j6VwFOiYKgn2dPCOea5Nr/oCoRN+MocWlk8JuDgL7p
82cnH9Rlip3QQy/TlZo8gsfX3+4fzqyX5bKaL2cnzL7X0Sg7fI1z4IBBHQM4Zz0pwNl9iYfb
L/fQNWgcPNS5pXVOu0k0D3vVwx0yvsQiNDOpmixxqqb2PTVYvdIUrYc1mq7ncMHyWddAbQZ+
9DNNjnuBav3rE+MUQImqVz3/9nL/cv78wVrueFOe5dGqHp0MVd00d0aCG67Zxd+ef386+7Y+
cUnPnhKtPAz8NUHEH443yU0tch8uVb6Ym80GJ8CNHScXMEIuVmbEcHSr6khlPrPpo7O5z16C
L/8ku4FwG/4HzKdTPynwiQSu8Txcx+LTpywJEDbLzQW1NZu+0wzg9Kfrir2coLZmj5BkEFcJ
iVCZqXaC5FJTIMICHxxqJTGhGgmFdtgBahvio9K8WySVB5gc/cOwjuSMQAJUmTc0pZ2KGaDJ
I65M8+jpbyxLTN9B3pJ9sE0ktrDCFBLQCE6nBpWhc7T09Of57du3ty+jrQfHcEWDRT6oEMnq
uKH0WyloBUgVNWTaQqCX2kDgyVqCjrH86NDOd5SHtburIBxJXQUJotktboKUzCuKhRdHVSdB
il9rl9y977V4oNZcobar08mrCJnPpwsfrszK66NpoPIPO7xQwgFlfcg8oPXq26+jo6L3KEVq
5PYan/z0CN+b1acbfN/fsN3gygGnMzV1ZAz1nRHVVI+0REdxTOxVMtw4FqLxSyykqzuPSWEh
Mt2CPhWJhU5vO7OxrOCavs8Lq3GSlRD57ShqiMCmA0wyqZvBD3tbFvsQU52YhyTL9pkw0jj1
xE6YwPf2yZ6G1cECudPEKvS6d5IwUNwJiMgghzgKfQOs214gtYF8JK1CYNB6k5cyFbGK7hGT
y10F/jGqUZokajBGbG5UiMh6Y6c4n/mI9SOOL8QOhFqCd0Td1MQ5boDa7pp/YDiMcQy+GN/N
qPcF96+vj8+vby/np/bL2788xjzBprcDTBecAfb6BU5H924VqZ6CvGv4in2AWJTO32uA1DmE
GmucNs/ycaJuxCht14ySIJLSGE1F2jvXHojVOCmvsndoZhYdp+6OuWfEQFoQ7Ki8yZRySD1e
E5bhnaI3cTZOdO3qR7ggbdBdQDhZR7kXv/RHBfcx/iaPXYI2uuHH9bAypDcKr7numfXTDlRF
he/pd6iZsLhFVkfZVlwzuqn4s3Wc6rMxG4gO5HE9hErpU4gDXmbKCpWyzV1S7ahhTI+Aex0j
0vJkeyqEYwhrbouU2DebTqS2ipw6Alhg0aADwDWzD1LRC9Adf1fv4mxwnlic718m6eP5CYKu
fP3653Nvnf+TYf25E0PxrVCTAJcvAGvq9HpzPRUsK5VTABaYGdZbAJhi+bwDWjVnFVMVy6ur
ABTkXCwCEG3MC+wlkCtZl12AjBAceIPIaj3iZ+hQr40sHEzUb2XdzGfmN6/pDvVTgbh5Xhew
2BhvoGedqkAfdGAglUV6rItlEAzluVnig9DsyHXqMQT7pY6NrS44OdB+mIs7N9IGglMzcBXm
JZbq40MHT0quM9m7yEH8YiqBW+tD8eIU2GTc5BVen3ukzambYTMnF7HISrziminEpm222Ln1
x29jASLp+2gjheDSDKyquERc6WhGoqvFwIFKOaTjIrXxLwyS21RkGY20dxSFbYOAR1HwJXsc
oY2hVmVm5HxclEGRVrMwZu3uzhTqoHRJwuwM8Uqrfa9+CxjnmYWIXHdwz62Qm2sPJL21w8jo
GLDcB/McL1h9ijjAqg3MvDPNE0PoxZQ0QwLOw3vnAIMbZm9CNr8Kz2U2ePJlvpXyJiYPdrOk
P37FkCkH+Om0ERPoqwPJGcZaF+s2JsCH2WgC7b6wToVp5D6fDWbUssDmu8CDozewspRpCBX1
dQg2G/PV4nQaSLYm969myOfOI4oNONbAjcQnt/Jl93/TQxxIJbsxHYonTaMipA1ZAvhTW2PT
eUqv05i+rnUa4yDJOSXbWigrVh4WbdMgQ+gL8LsvNHJxVov8l7rMf0mf7l+/TB6+PH4PnF5B
M6SKJvlrEieSncwBbsYeD4ncvW8PgUsbcVD7xKLsin0JpdNRIjMD3jWJ/axwuJ+OMRthZGzb
pMyTpmb9DMZkJIqb1kYAbWfvUufvUq/epa7fz3f1Lnkx92tOzQJYiO8qgLHSEOe8AxOozIi+
YGjR3KzJsY+bZU346L5RrO/W+IzSAiUDRKSd9aPtrfn99+9wLbjrouCG2/XZ+wczGfIuW5qt
XnLqYxKwPgeuBnJvnDjQu92JaebbjNg2/bGm3vwxS5YUH4MEaEkXYXYeIpdpOEsz0UHoLkGj
3tuhLpfzqYzZZxipyBLYRK+XyynDyKGcHb4VRIiOsf4eYNsF2kNthimjwFmi14zZ4Cambzl9
fvrtAzhmv7deqAzT+GE5pJrL5ZL1a4dBAM4UuwRHJL41NhSwd0gz4jWMwC52sAu8eDfG442K
fL6s1qwqtRG9l6x/68yrmmrnQeaHY3B21ZRm/+c26ji+R0dNahtfDqiz+ZoRzagxWyxNO6Fd
puZu/XcC8ePrHx/K5w8SRtDYAb+tiVJu8Z0i57vGSOP5x9mVjzYoDAv0RiPitomUrI92qFnT
ApQAbyR3Iyl4FLNMcg+XwwtxYqQRNUrwRwQmall3fj+2rndPf6TpbLqeztbeK502g6xSllDa
mQA8JIFcP7JQWU4SXXpAjWRbhqoCwnaVhdwpPhtQoludA15Q3+ONrdnp9J9ZITrR+0lGUWPH
XIjL9LOrAC5FGmKH/4hmYaD4Bg4D6ZCuZlOqbhloZqinmeQCliXtlFbLKSuckaf8ztqB3ZTS
Br615+i2KWGiN+f0hPkJqnrrZgw7jrPKtM/kf9zv+aSS+eTr+eu3l7/Dc6tlo2nf2ihLAbHN
7HH8KT9v1rMfP3y8Y7Z77yvrLNZsEPCGzdBTnbW3exGTzZN98WR3VFzM3Ec+0B4zG7hU7yAq
EZsbLUOURJ3Z2XzKaWDh4C38QAC/oKHcmHgfN6jF8IptVul9oRp6HGxAs/kxL0WagBAdi7q3
NGAi6uwuTIrvCpErSRPuhmUAo9OYwcl2s0ypLxnznJPjRNhZsQRsZBeWCNlLlmmv1iQYBEYi
YdjNXqQ7XkKx3SzUbnXISXxPFaf1+nqz8lJqzfp35aMFbCyxjaoLgOkBbbE3DRThi0I9BSyc
tIYOr6rF3B72DmX+ZAZgKNYKhNKsblup4HQC218BoKVWbSPIhdcur1jIzWrq43sXVG3It8dl
eewWuZFSAFNGghVi1MYOczGv1pxuz+bK8LtxHaE2h6e2Cy5ooyax6IpdBeNXelDfBMBShzhP
ax8kAhMCu2+arUI0T5bCxBifgMi4BnvKm0bGh3gE7lQ1+lKBlHxkukoI8A2jgd4zdOcZ4f5X
hyqu1tjqoDjkCQ9B31f7IR9BbT8c9lSPrw++OsnsurSZvMER1CI7TOfYGiBezpenNq7KJghS
ZRkmkEk/3uf5HZ1Sqp0oGrwDdNuOXJkVHTvUhxijqpRo0DcqzVk1WOj6dMI3aqXeLOb6ajrD
rZKbLDS+J5UUMiv1vk7A0JYZ7+2qVmVoprwFu1tZqgJMAVCqVaw36+lckMAsOptvptMFR/BG
ra/3xlCWywAh2s2u1yP4dQC3Jdlg25NdLleLJVIQxHq2Ws9xzcFsdL2cISzKq+l6yZ9pU3cY
aeXKevXDMcPAgqiz1k+12Fzhj4GVz9S3keqrResw9EVkzFeCaLnt47C2TBnsgox/XFJY7sAN
ZH9kztOymsmehgL+zbvVy8UFS0zauW+66HDTueaok17ApQdmyVZg54gdnIvTan3ts28W8rQK
oKfTFYJldG1kXRZozGL8gPICtkLrfT5o6VzY1vOP+9eJAvOFP7+en99eJ69fwAIUOXB7Mtv6
yWczlTx+hz8vNdGANsjvljCv0J5CKK5fOQt78PRxP0mrrZj89vjy9S+T8+Tzt7+eras4584a
mfSDHaAAJU2VfRwMVt/OTxMjPVnNudvhDoaqUqUB+FBWAfSS0A7izI0R5f3L51A2o/zfvr98
A/3Vt5eJfrt/O0/y++f7389Q1ZOfZKnzn/mpFZRvSK77dLOdON5iG1X7POyF2qSujXBeJxIW
obvLGEnkjmxU5SmzweuDulYgdmEqBRhrj7AkyQ7TujrQqlf6eAPGSkY5jqBUCzPtgySMdxAS
xzC075Bzf4sUPH6AS/sWRWXEBHtKcjG9tKXsijd5+/v7efKT6dZ//Hvydv/9/O+JjD+YkfYz
MsTspRQsJuxqhzU+VmpiLdq/XYcwiEwU413WkPA2gGEtiP2yYR1juAQtjSCnQhbPyu2W2AxZ
VNvrF2DYQqqo6Yf+K2tE2MwFmq1NZRBW9v8QRQs9imcq0iL8Au8OgEJwU2pz60h1FcwhK4/O
7AUt1FZyJ+5aLGRXCX2nU56GPG2jhWMKUK6ClKg4zUcJJ1ODJRbokjlj7TvO4tiezD87glhC
u0rz+jHcmxMWKXvUr2AhRc1TFEIG8hFKXpNEOwCO88BpY92dy6Kbsz0HxMuFA2WzaWxz/XGJ
dOw9i1uoXIxSP4vOwE3om4/em6C4cyY6YExa8LkA2Da82Jt/LPbmn4u9ebfYm3eKvfmvir25
YsUGgC/zrgsoNyj4/HgYwYKJOEpjCpslvDT5YZ97s3QF24KSlxt0kGbwcLiWOZ4Q3WRmMpxj
hZMRmOwSUSRHcmlwIOALBxdQqCwqTwEKl8AGQqBeqmYRROdQK9a8bkvU8vit9+hzP9V9qneS
Dy8HUh0NIXj6z270G7GOGtxiPah9xFMMfXJTZoGVUAPU9V5vFozz02K2mfHyp/sGtlcuUjRf
ECpviSgUMfnrQUEsyFxZmoTPZPouXy7k2oyG+SgF7C86zZlZAG2It4+zMd4+HJ/YaqRnYFzQ
yJZjdTXGkfvfVPFebxAeGGLAqeWMhW/NEm4aw/QsXjG3mWhxWzcyB2zuz/zA2S8syPEVLItV
GtLPuYaWi83yBx/I8K2b6ysGH+Pr2YZnG5plqjy0tlT5eop38G6FTOn3WZDbirrld5dkWpWh
zt2v+2Zg5VLxhTLm8lW8a+tY8EwNuqvMDteHkzzAK7I9z6jUsevz1Ep2oO0zXiWAxnZlsNso
3nktmdavk5OG9gXdVOHEwtis8YFWBo7eBNzuJFARgFblgxdmOcTffp389fj2xST1/EGn6eT5
/s1sWS5XNpHkCEkIYqI6QIHZzMIqPzFEJgfBoBMcsjDstqyxTxubkalvOVvNTzx/kHhCBdMq
w1t7C6XpICGbj33gtfDw5+vbt68TM9eEaqCKjXxMNzOQ6K1uvKrWJ5ZzlLsXXd4GCRfAsqGt
MrSaUvyT46P0EXuD0S8dUPjA7fFDiADHg2AEweD8wICCA6DfUDgctUVrKbzKwTYmHaI5cjgy
ZJ/xBj4o/rEH1Zj1YbDCq/7beq5sR8IZOAT7c3BILTTcDE89vMGrtsMa03I+WK1X1yeGGtl1
deWBekkMRAZwEQRXHLyr6NGTRc3KWDPIiByLFX8bQK+YAJ7mRQhdBEHaHy1BNev5jHNbkOf2
qzXi5rnloj4QPa5Fi6SRAVQVvwpsj+VQvb6+mi0ZakYPHWkONeKY/w1mIphP5171wPxQZrzL
gLsLIkA7FNsMWkTL2XzKW5ZoDBySmO+vIeoqT9IMq9XaS0BxtqbUOxXxT2pqlWYJ/yIywixy
VEVUFoN9SqXKD9+en/7mo4wNLdu/p1QYdq0ZqHPXPvxDSnK84OrbW3QcZzpGqT91nhiIWflv
909P/7l/+GPyy+Tp/Pv9Q+BMHl72TAFskt6WJHAchLHcLFX7BkIHE6e1BgYTWjw289hqB6Ye
MvMRn+lquSKYCzIk8LFW3p0LktL7Ab0idkbmnvma0qGdNsvbkQ5nk7k1qWlU4AwyRs1l+ELa
QAOzhG2CKZYgex5nFOC8f/l37eA9BfYUSuMpxsBVUptB04B5P/XEY2j22JUguhCV3pUUbHbK
WtgezD6+LHi+rD57pNX5bQCVWSJI2KbYGpbRqlJU2jMQOLyGSwG6IjsTQ6HiugE+JTWtvkBf
wWiLXQgRguZNRawKDOKuZBAozcRNQrnALKcJQW2KvZlA7TPfVN2HW4MeNO8NISPJ4aPZXilm
OAIYHEPh/gRYRbV4AEHlopUFjuIj29NsXixJHOulMzCgXDqqPCzda3JW757piUyH4Qx6Nqym
6LCAWqOjEIuqDiPuTXps0D+7A5IkSSazxeZq8lP6+HI+mp+f/YODVNUJvezfI21JxPYBNtUx
D8DEIuaClpqGLPPcueRKEQZ+Gm8WNDpI4dz78pjc7o1s+Im7HCStyv1qNgk+Ce2RLm59IPoz
YajLfRHXZaS4o60Lh9kElqMZgMeVQwLdkftUvPDAxaFIZGBgiCpKSOpxD4CGBhyhDMzRG3fu
tiUmckJqPIBBaDMb2hKrWi+Yb09l42RlzH8ZIHBc0tTmD9JETeTdE232BXloD7Y31KXWxLfI
IWT/QXpfkXl+nQ/YY6beF9skB/PwCyZq6mXZPbdG7Jv54HTpg8QjWIcR18g9Vuab6Y8fYzie
3fqUlZkMQ/xGJMV7EEagEh04AXf3wjQD6XgCiJzTdF7HBUsrKXzAV5I42DQm3MKr8aDqaRZu
m1M7Wx3foa7fI169R5yPEut3M63fy7R+L9PazxTmQ/BxgOcdwD95zuA/2Tbx67FQEm5OBEFr
MWo6tRqnqri5vjb9lnJYdI5tWTAaKsZAq+UBLDNHqOECiTwSWgtyJEvxUJa7slaf8HhGYLCI
gj+HuMwOJDHDJAmj9gO84xnC0cCxElyDuuiwCd3lOSWFZrntkpGKMlNsOZyow/15ZCni7X/s
/XriB8oicI7MHDFe8DvsfdTCOyxDWYRrfw/2FJhMkg6y8tdXilG//Bbjr7mZPTHLu/VY2G3V
+psVby+P//nz7fx5ov96fHv4MhEvD18e384Pb3++BO689G7488N6naym2BCUkoi+vidFRgzU
KRoF1p0k+VJq32tXFGtb0C4kXuoPZU1OUJq7ald6a5F7U8SiahJi6mcBe0MqJSIZfmubYErS
zBazU5gzaxIybGRCDp/cc1vmysyTamsGE+6Fzg6o0SOlwNtm87CezWbULrOCtQirdwxXe9pi
A/keoZ55IRemdcYZY2815gHcMksmMvYwqiVgqs1ugt7uwOlCi5dkaczItJjN6FNCH3GpspH2
2Jt9IJ6b7HNbROv1lPVXKeKEy35RMFEnruIuGGHvDubBWp6DWkMnGY3F42hQd+/RESBzaJf/
Z+zKlh23keyv1A90tEhqoR78AJGUhCuC5OUiUfeFUbZr2o6oLndU2TH9+YMESCkzAcjzULeE
c7AR+5LIxF6qEeuCJM3LNKmE+h2Zc+paWV85yJatFuSL18OJ1HB37/pCUb1LOiBz8fRoQWbE
jNahErxSyrHIhW6c3Kr0EkcmrhIryu7PeqtQtDART1grNsavAfxwQoVVyvdBhkag+UIO1cN8
Q9dHPmyKTh448WBrH0Y7K8IHuotEDL0pfBLXo/979C4cfQ0dtLJxKjL8tDSvuDr2OZqc7Wb0
KpTY2cmLOFrhc/0Z0DNC+Zy2WSDjnNRNOhC5jbZYJRrHH2DT+aZ3vbp/CCrvnxfrES3Q5tPc
KV2j0SFX+2iF+pyOdBNv/QNOTsX48jLG90a6qdH95YKwb0ERFmogx9CHIqbDgXFzszozyno1
jvaDDsvWPVUNyHpUesIDAyJTEaroYiSXWDFZs4xYMBlc8/mjEQqgC1gUJcj4lHpkRPk9y3Fz
zuOJdn6dz9WaTnznqmOrhTN+rw+0XnMcKRL8uDMql3MT8Yli9sWUMhbEX0E1HBsntuVyOhAH
rz4NERPJI/FPZ3Tj5DVtQR6rO/EbiCS1JvnULidqwPjMYEAaMyB0FAIIp3VU0erCnC+arEzj
DV5Jvin/csW5EFPXuW0837XCMQfcQfuebo0i2qbMsNYFN2lwOVfIgEGp0Jvbyz2mLh4O51tn
WlREzqscdUOvHICW9AKykjMwXaQZiD84L8eN681CPO0H6mSgu7lxzBhvhZahT5YNZM+u8eJm
xhu9RGrxHE9xdym7FKjMiIbDS5em65i68aGSdevYSZgPHYhpAmdp1GworbI4fcPboQWx5/D8
3b5mx3itaf84o+4tLirtila4NR4LUVb+yagSei+B5RpdoEuTNPYnbEwIVDXpZUdjX4EsIiz0
ol2nyZ4kEF+CpVld9YoLLQH1xj4rctIVke/6wh7tkHFRh6rZagRMGIBVmepE1EWehZ5fziiu
ewFKoI78tHlO1gqsPan3UiRki/te0lW5dfN18IySxjtjrCfPKOtH7+WJjn+j7pc0XfxSXjuc
HBR47Q0uJ2XA+FiPi2IQJdWS/Z6J3SrQktsCdrhoxE+jZI+PPcHd17UDTETJ4gKaE87+Junt
7MKmUbynqJEHamep5yfVptF2H8hvVVDh1jOdFlpx9Y88RJih3a7WgQIBQy9YpyRzI6+dUHCC
jvJiJvNQ1+iK4t1PSFLBXbaPV0kU8Io/XXZ7Irkquwh3644IMoICQPzO2gBZDq9lKoqyJvnw
6LzrwBlT5OVjIzMqVKvpfRSRl88LBucU5+lc1xefdjXjax0YDrvejPUonV7BEQezwGkwV9wi
vwHuiExYWDbv6QpvKCxcNlmUjg6sCnpDf/MftFi8qzN4hebAWHZkhoZqlO6XBEbqDl8cnUXT
3FWBNX/a656nOwODPPjItZKDP+J7VTdUvn5GjIReAdft+MwIBe2L84C/i7uxV+xNTlmj1xOC
GF0g3QSUGLHrrmdcRCZIO6b2TKaXB8Q2eYCDYu+M3O2jiG/yg6Rp3dNtQ5r7A00M+mjyM34Y
ulnxnffhG/IlK9ef60tUd3+O2D18nuMWVhxJOwYnFya/HPG2SzZEU2Et8hY0a7Y+bCpBUMAc
f2PZrvPdqru1L8al/KSRoAInoaeyqtc1Qi8o+3SVjAxTOQXm/QYFc3GVxrwRBt9h8UWhElTE
YyCTmchZNmYpTgrCWbEufJl1FIdBjCJw1G6WP0uJLPh8jun6zu6naugc3DxH4mC646DMmpKH
nud+ClbmMEawotPzebTCcqJgzKPoo1UUsQ+zC3xW8I1e0a5TD7jduaFrqwYIw0c5FryGc9B2
IPuDINrJAaX6nw3ETyQNWGf0YsCA89kjT0iXnRpGP+pLcKGgQ7UFzyHU51BJcoTyICS1YTAX
qN4I7fcbIuVJTuSahjqmQwftiIG6l+tpsKAgN3oCmGoa5stIUNGTNA3X5OIWABKsp+nX1Mo2
RCvoHRxARvk5ucjryKd2JbZ/DJxRtAeCxHh1bQiw79ozzIiWwC8kfQjaBKxBOCYaAEQmsK4e
QC7iRtYYgDXFSXQDC9r2ZRph/QtPMKagntx2ZGUBoP5Hppslm6DDJtqNIWI/RbtUuGyWZ8xC
HGKmAi8OMFFlHuI86DKQYR4IdZAeJlf7LZYmWfCu3e9WKy+eenE9qu42vMgWZu9lTuU2XnlK
poLBLPUkAsPmwYVV1u3SxOO/1TO2fSjsL5JuOHRmv0tfb7peKAda49Rmm7BGI6p4F7NcWANR
zF+rdNcdWIEUjV61xmmassadxWQfseTtQwwtb98mz2MaJ9FqcnoEkBdRKukp8Hc9695uguXz
jA1lLl5l1W+ikTUYKChuSd2YomrOTj46WbStmBy/13Lra1fZeU+E3G9k3Qmu59W1Iptn7U6J
gREQOOUqBEkEOKsemxEAmSP6pqaWYYCA17yz/JnVrQ3A+f/hD+zSGH3NZDenvW4uzOnJz8YK
KhctR5mYlfEINqpAPUpVlDRT+8t0vnGEl5RF82PnGiqx1KHP6mJ0zdMYlnvm+dOQOB+c1Pwp
db014mP+72CFx330437vy/psBAjPTDOpqyRzcskNY8wlY8vQyBASDbrLp9WFcsoXT1oPKPSB
51tLrWe25T6iNigt4hjVnGHXxtDC3JrMg7IEdS62l5K7mXmqGSQj8oy5DRVQR6R+xsHaEXs0
LNrNJkbXvzepp4po5QCT7Fo4RHcJX2LkNsW6nYYIGG+JgLmf9EBZ/QEeSD3UBm9ZlRC7YzPg
xk/HK1VQWTeiPAkkLLiP3TbbrEZaZzhKn+RGQhywKhYU6Yi9M/CiB7bOeJyMBk7DP5XdER/e
TffTSwfWQF1VeJoPS5AkfyNBknA7a/NX0VNUE48DnO/TyYUqFyobFzuzbDDLgxph/RAg/i5m
nfAXRA/oVZk8fbwqmdmXk7EZd7M3E6FM0ud8KBusYJ++TYsBfdWzrTfcJpAvYENN55mG423x
1GaKKi4HpCNbQECOXmQ2T3nI8jCputNhOHpo1vQWmNoMfMSVyYLC7sgCaH5AAO7PTGwFU+x6
Xja3mBybzYBrkHshWJ0DHPMI4lAEQBiz3uytgGXsw+BsqPEKdyHJ6eYCssyU8qAZ7nayfONd
SSPr/XZDgGS/BsCckv3+v1/B+emf8At8fsq//PzXv/4F+usdKzNL9KFk3dFdMzeiLXcGWIfU
aH5VxK2Y24Q6wJOR+UQBvcF5nWUT0s3xE/ZkeNag4zZO3uBa8pIbNma4+q37adYmREzVlagN
nOkGyzguGJ7e9WZbEb2Pxm2e9CkHtY/pjrcJZFAricZJMHzNo+pV7mAVyN2WDgyDNMdqXT91
VtNhoNmsnVU4YI4n+kpWA1RbowUeOk6sXkHK0/ZlCmSz9lejIz2i+5Ze0eBrwAWhOX2gdAh8
wjjTD9Tt2BanthUfMDykhGbyggpG+fBAsq2ggWMBsxlgn7GgdMheUBZjmV4ChVvkUpBdrNJr
tlU0+L23gp4Btn084iFYu9erFWkeGto40DbiflI3mIX0ryTBS1XCbELMJhwm3q949khxtf0u
YQCE9kOB7M2MJ3sLs0v8jC/jMxOIbaguVX2rOEVtCz4xbknKVOFrgtfMgvMiGT2pLn7dQRaR
Vlm0l2JGIZ+EMzfMHOttpPlyeQdzFpuuOLBzACcbJexlGZRG+zgrHKhzoZxBuzgRLnTgAdO0
cOPiUBpHPC7I10AgOuvPAK9nC7JK9s7XSyLO9DF/iQ+3xzcSH5WC73EcBxeZwCBpR2x/kYrF
73a0Y9rj5yBt51lJAEhHVECCG1WihfNG9WBYt/VOoyQMnm5w1D3BoxhLwFk3D2sxkhKAZENf
UkmFW8nsZRs3j9hiNGJz7fNUAEs1DuDv+LjneFKGoekjp09HwR1F2HbZggQt0p5vne8awZ60
z4ezZpV5+12J8RM88P765cePT4fvf3z+9efP33511ZJby7QSpiqFP/SJsnaAGa9BW3KUrfNk
plW0wrM2UpGLPpRdECZDDSjbUBns2DKAXP8ZZMTaoXW31q2wu+NjaFGN5OwmWa2IoNdRtPRu
Lu+ybP184GacELPHl1lxkneuOkuSuuCl/7P8StEc2N2U/gK4HnwC8JIfmoRePTr3dIg7iktR
HryU6NNte4zxxY2P9ew6nr6U9rJ+W/ujyLKY6EMisZMmhZn8uIuxFOxVjfBqDHnu8oq6Jrku
GULawIJM1zcGKuLNdwH8COvcIRtGDGR4MBioFD1iywcGtW3QamHQ7k//8+Wzebf446+frcJt
vA+EALmpVfsa5BFsXf7+7a//fvrt8/dfrdJuqsO6+fzjB6iD+0XzTnztFR4xmIzZjeg/fvnt
87dvX75++s/3P/7845c/vi6ZQkFNiKkYiMqRYhI1efEAfqoaFOXl1kQcvld/0GXpC3Qp7g02
B2yJqG+3jmdsls9CMBTZpUdqP+r8e/f5v4tKiy+/8pKYI99OCY8J7PF1dL9q8G5FdJta8NjK
/sPjWVzVJCJH1+FciGXnYLkszqWuaYfoirw8iAE3xbkQiv4NX95hdBrcIsvwAYsFDxedy7UT
R5f1xo4QrmrLnMQHPqyy4PnIxO8sfNtu97HPb+eUYgFHEnqx7otmmQBRpdpSNTX66ceX70ZQ
6tl1SO3/PHeMT07Xmj+136xTpzHpXJJh6YGuu7TzNgHIeVPxQSEjj7zAxRWOPryZP2SQfDBK
5nlZ0E0CDad79AtqUS350+PNeCN9AwfOpiDnWMuoodFDNB3oLtXHXtdBvn8ZGtsdMRkp6Eur
ZUDEK6onNh1a6YndUE2Ygr+0qhAJl8My93NwWdY/J//Ht5zkSRBphRlYGsTTmPKM63nLe4q+
8EYPR1l6jtAXH2BUwE1PEa0OCI1clK00z3eYXv9NnKxBKzoDK/v9XcOhMqrlQ4Hpv82kF25+
Nojua/TlzYIaiSsPTk927JR8VaZvcrxriiIn87LF4dSposJvBmcDmQX56DtH0RDpNYt1gi8j
6MK3wn1NO5wnKho6FZXjrW2bh9kA+e0/f/0ZNAAhq2ZAeTVOfpZtsONxUoUqifZJy4C2HqKR
x8JdoxfExYXYfLOMEn0rx5l5GIT+CjuPh4bWHyyLYMFdz3duMgs+NZ3AAjuM7bK2KPQK66do
Fa9f+7n/tNum1MtbffckXVy9IJqUbNmHbHzaAHptc6iJgv8F0QvdhqoLpQwWRGLM3sf0l4Mv
lfc+Wu18ibz3cbT1EVnZdLsIHxg8qPLiT4TKfBLYNKDCF6jPxHaNTTNjJl1Hvu+3jcuXM5Um
WGCBEImP0AvHXbLxFaXC8ixPtGn11txDVMWtx4PHg6ibooITBF9sp7rMjxLe6zBT8g8fXV/f
xA2r40MU/AYbIj5yqPyVpBMzobwRKizh+vwC3YvX3gpKdCv01UN/K9erxNesxkADBY0vU+HL
lZ50dDP093o02IJTjw+xB5pESey4P/DDPffB8HBO/4/3hE9S7+xFQ4WdnqSju/dJwcrvYkTW
fGxRCr0IJsZ2nynC+rgkxkyfsdZDdr5Ib5zHOoODXTdSWNLgRzAWFQ3s1yA+zhwytSGq5i2c
3UUjOAgfQk2XUfwl16nD4BTetRvHUTgJMQFz+2FL3fhSeZL0zGEZ/EGCDR2CL8gkKqEbhI9I
ch+KF4sPNKsPWL/LAz8dY1+apxYLdxN4Ul5mkHp8VVif6YMzN74i81GdzIubpML9D7JXWLLi
GZ157RokaOlyMsbSug9Sb25aWfvyoMTJPDf35R00pNatLzFDHYgGhycHEp7+773JXDs8zMe5
qM6Dr/7yw95XG0IVZN/yTGPQe7FTK46jr+l0mxWWlH0QsDQZvPU+kiMTAk/HY4ihaz9UDeVF
txS9UIh4/+hBNBtrRzVuK0edFRnOBKZkQy6WEHXq8QEuIs6iupH3K4i7HLTDYexwpnOf1Wrt
ZBwGNLvoQwGfIAi5NCAKSMQIEJ+mjUq32MgjZkXe7VJsF5CSu3S3e8HtX3F0DPPw5JaC8K1e
AEcvwhu7nArLzBJ6gJfMYyZbP38YYr2DTPwkPFSqq2KSWZUmePFGPN3TrFenCIuSUr7vu4br
/XU9BL9w5oMlZHmud8Ln42+SWIfTyMV+lazDHH7sQjiYp/DZGybPQjXdWYZyXRR9IDfFSZQi
0Igt5ywLsJdjv42TQDM/Dm+y7wY/earrXAbSlaXULSlE0idfJM6h+ggVAH0PS5hAkZpxY7pR
wzeuh2BD0DuIKEpDgfUuYkMUDRBSdVEUaCK6ix7hjEk2IQ9srUYKT43boZz6LpBnWRWjDJSH
uuyiQNPUOxllbED7SzjvdTvZjKtAOzG/W3k6B8Kb3zcZqL8ebB4lyWYMf9WQHaJ1qKxfjWi3
vDfPQ4N1fNPbxyjQUG9qvxtfcPgIjnOhgjZcYIQ1L31q1dSd7AO9QJGLTtoco2SXvoj51Thh
XvSJ6k0GKhD4RIU52b8gC7M0CvMvOj3QucqgYYRmFJN8+6LHGA85l4RxMgGKEfRa428iOtXE
qgyn30RHlHs6RREaqgwZB0Z4I1lwB1048lXcvV4TZesNWaVzTy9GBxOH6O4vSsD8ln0casB9
t05DvVRXoZmHAqlrOl6txhfztvURGDItGegalgws1xqirhszXR+RTQ3lyIEKoYZqHajIbmjX
geLpxnS7CX1c0203q12g736wXRtZytSlPLRyuh43gXTb+qzsug+frs0HMRKPxxZbFs1TXREj
EYgNkXpxG62d0x6L0gGaMGQZNjNGDbQAtR/0vMbSByXIK+T5aDcZV/pLe3KWN5+Bq3S/jqbm
1nqyDeeIu+0+mVPz0Ok+3vg/2ZD7XSioHbIhXX++lBLp2v0S1QzJyoVPTSxcDN7ZF0VDJB6e
VC/L3jnBnQtZz8stHDwUMafgmFFPFzPtsGP/tveCc0rL0xNaB/WtaJVwo7sXTAjXwpmKVk4q
bXEaSjAAGCjxVs9F4eI2/SyO0rAPMTaxbt5N4WRnPhd9Efns4SrJedGDBB1NfnLw3vI0olRw
+xlKr8l0n98munWpwcOlm52zo25u6lVbaetetHfQFlfnrhe78fF3A8MFughw28TP2cXZ5Ps4
915K5GOZ+MYXA/sHGEt5RhipdNFmTsFlSiRkzU9gXxpdnc2Djh61WuF+fnuNYTgNDGWG3m5e
0zuXbpXke2ADkRwahHy8QeLc2MPEp3YGP+ITrBmJOZI8jHmdl5tg+c/6E7d5ThcCxgl/6cNm
CzeiJRcLM5pJciVgUT3beVAie2ihWdO5x7OGFLV3bwO0mc+3aHwJ1mWTaQpfmM+fCGsDGs/A
ygJOGGkxLMhUdZtN6sHLtQcs1BCtLpGHOSq7p7UyI799/v75lz+/fHfFRolSkiuWB57NwfSt
qLrSPBXvsM/FwxM731zs2iN4Okhm8Weo5LjXQ3GPNXHlxbXpu9m+lQ4ljfFVYlloeZxIwj1B
nSBsc+PNFteMXvgjQ66oTYM+vJ5WR3bPSpHjJLP7BxzFYzU69SjsA8CS3mVo2ChpIa3/XmUw
wxHDxDM2nbDKr/qjVkRgBesW48IH0wk/urKqj9t6ILKPFu2oxujiqvD7eu2+WMBaSv3y/ffP
X13xjrkYC9GW94wo2bNEGuMVCwJ1Ak0L6r2L3JgUJI0J+ztCgV78nNO6SALEBCsiqClwRFTt
NOha6n5a+9hWtyCpildeirEvqrzI/dErUenGWLd94Eu7MzzCk+17qMDAVGGYb7vA9x4yFafJ
xkpaPFUT4jLufLJIJPFbINE+TtPRzzl6BDEJlzbUPjouKRkqQt2VHIbamTTNtfrj2z8gAMgT
Qrs11lQcOZo5PHvOj9FgC7Nsk7sfYBk9iore4S6nXG/Gldv8XOEMRgQzovcaCVVDiXE3QmIJ
+okF44fWXpKDKUYEQ3bnqfP0NAs/+1rs51/HGh5wZt7X+enCCIFuYsv8RM2czUHe8Ai7JJtl
1dgE4PDHZNFWdnBS6c3bg34RkCztHJYs82ZWD2KHos3F/1H2dc2N20qbf8VXuzm179nwW9RW
5QIiKYljUuQQlEzPjcrxOInr9dhTtuecZH/9ogGSQjeaPtmLZKznAfHZABpAo8HkR40UScgk
N+LLvcHoVZ96sTsKqsu5/N+N56Im3LZCuqPmGPyjJHU0qi+YYZcO2nagjTjmHSxEfT8OPO+D
kEu5L7dDMiRuVwQX0WweJ2K5cw/yLNhPZ2bx2wFuNKlFq+TTxvRyDsDw5O+FYARNKWCuMKFn
fS7YslAoTo0WpgV9QnZt4HygsMvwEtLxRc11amZiM3yhFjOjfhWDgCdpy12ZNRV6cH4pyHL/
V6tRyfRfDS/XOGz/+WHMfFeHbnVodDmyU7E58u1nqMUPs76riNUO3JBpO6Ww2Q4UO22vYmnl
zHjYtsgqc3/KxttPGEO6z/gapBNX2dYlWB3k6BVKjbYCHJqTt28tRvb4LTNNjU4YdCm22Nof
aFsbHwGwQYAXL4xnAEl5WW4JdCP6bJ83NGW9OdbYZh9q6URfHJ0hGNhhUYnU+AtLn3i7MMVw
e7Cdf1gxtmxURM66cJ1Ya1GwOyuNsyNzd2m83rG85IQ7gbS54QKQxouTtNdtfbbD2dJAqS3E
qCZnU641uM0ejqemp+RCbLIPwy9tEC0z5NyRsmhShrUtWmhqn88SuZJQY3V1iyzpJoT4RZjh
ZjvVvsoKY0COdqxU+bVlpqqiBsNwLGmrsRpTqxRsQq1A4zfWeDz+8fT++P3p4U/V0pB49sfj
dzYHamDfmC1GFWVVFQf7XYExUjK+TGibiXUc+UvEny6B/NMCuC+qtui0wyZMEJtFndFq12zK
3gVVcnY9z3tfmx9vVpHHXnClYlb4Hy9v71f3L8/vry9PT9AbHAtzHXnpx/YIP4NJyIADBet8
Zb87P2Lwch+pBfPSEQZLZPygEWmfDQLSluUQYeigT6RIXLKUcbyOHTBB11MNtrZd0QOGPJyP
gLGkuYj2X2/vD9+uflUVO1bk1U/fVA0//XX18O3Xh69fH75e/TyG+qdaFN4rafwHqethoOkw
Loo1DN6s+g3pD9DfXDHNC1nuDtqtDtbtCem67KcB0C0nxRVbNPpqaBd4RDzdHJU16QKfvkSr
lDTDdVG3VY4xtY63jVp1l+oT5KYDsIYYxWsxyYRdwnnzQXODgMIxGw/AdmVJal+t7GrVDauC
Ck6NDt81djwkavoMbkjVHQ9luy+RWmCh5y3GjYpMsKpd04J3mb4RpGWy+FPNcM93TyCcP5sO
f/f17vv7UkfPywaMpY90QM6rA2njVpB9cgs8V9gKR+eq2TT99vjly7nBCofiegHG+ScidH15
uCW21LrPtXDf0GyQ6jI273+YsX0soNX5cOHGOwDwYsoBOUWDJuqPG+uqHSD4AdsZcjwrmQ4C
/gm4ngU4jM0cjkZ2vDZuHW8fANVifOXFbIK25VV99waNmV0GcOeKEHxo1os4MrrPBNBQ6n/p
00CAjdt2LIhuTY04WblfwPNeOmV1vMpr8NiDjlvdYth5oVSD7o6VrsJp3CI4uQs8YnWZk52a
EcdPNACI+oOusnbtFBgPeoCoQU/9uy0pSj6sanD6ajuX1GibppF/7mwns4DrdaLtAGgCnWoG
MHdQ/ZIK/LUlEdNhFbDGdEwC1kJpkjRoX54/O4lB0LPv2T5aNdyh9ygBasssDBjoLD+TONXQ
bdywXHaTZ3RhTIcA7mMxGnWyLDM/VSqCRzJjeyYzv5VkO9/2aoFlXzvWIDbOGaGEQH2x6wSy
35zRwDvLbSVoDmYOmypoSimHVbndwiYPYYZhjZEBv2WlITL3aIzKJ5w2SKH+wU/tAPXl9vC5
bs+7UR7m4audPEKYcYyMWuo/pNrrTtA07UZkxtH1ZcTWJamKJBjsDa8W7W3DGraW9bkFr9zC
vtmBXiBXP9ACxJwjy9LSki+OAAB+enx4ts+VIQJYlkzftq10VxytfWVM/cCeCOCTMV72UzXe
lfAy6bVeZOOIRqrKkeGUxThTt8WNQ9acid8fnh9e795fXt0VRN+qLL7c/zeTwV518ThNVaSN
fecJ3h9JIg+/KoIDY/mE3KCRTa/PlEwgza7ZkpF2/Az2Z8hjUHradQPDG8626xmNOa9UaVRf
6PQuy8uHby+vf119u/v+Xan2EMLVPfR3q8h560fjdGY2YL+3L28Y+ym1CLhuDjSoswgwS1hn
OjQ1dyNaGrToOzEsFZ5ZDxi6YyrROWAzFbZJE7ly0OLwxQ9WFG0GtPNnwDZLByfaUcsljZjZ
k4ixLYMxkWLEQlSDpyGNY4LRYc+A9rinkS+zOMAaUAvBw5/f756/umLgXLq2UbyhODIHmpqR
QJp9jQZONRuUiVhvTYQ0/Iiy4cFai4aXgx97FOzVNB2k/myDU2/zv1EpAS3RaF9JJbu7lb3e
1ra1cyPd5NbLBaTtitU3DX0Shy/nvq8ITBego6CHa9thuqkgbQrnSGncxykNSux2TaXRy86j
ZaR7ODbWMVjjpgkHBz6VLw2nidtQCl77tOJHmNaQc+l6QvHDjhp1rkpolF5zmMGYCbleR/NE
pFS4jwWIbiYZ4a/OZbN35JgiXa6USn/uwqCWfJiYGsl9e4PZ6pRODrIwTFNauLaUjUSruJfX
/zxy1FkbhNJLp+/UyvjjD9BKeSRubC+H/jm7eP3y//nvx3Gr0NHFVEiz8tSeEWw3VRcml0Fk
u3jFTBpwTD1k/Af+Tc0RtnIy5lc+3f3rAWfVrNLBrx2OxOASnUfMMGTSSxcJcGKab9DbISiE
fRcBf5osEMHSF6G/RCx+EapRMePJVeItEOkisZCBtLDvPczM5nOAn7rVx0T6gRh75W6jdGuj
hZf+gLc6yqh/iDw7bwTsA6CnBo21O/lmNNSFZjq2DswEBuMrjOrXcwg2Js/c1J0YkfXpOoqF
y9AWsPF0CfcX8MDF6eWwCZcb6YLQUgMXeiTwOcycNNwz5bJKZltY8eyg94o1uvdghUc4WLGD
1m8+c/DtsajOO3G0T2GmqOBK5ApNOoRhamqyfK+FbSQ1Zdpt24mZLNjdGLvB9hk7hS9lCzlw
CS20XugSzrw6EVWbrmwV2cZtFXLCsUp+SfcgUAVbGfKjeMUkMF02WSjEmv9EEUymPsPlVllv
Ni6lxC7yY6bONbFmagSIIGaSB2Jlb05ahFKrmKhUlsKIickoVtwXo261ciVBi+m56rNgHTGd
d/LCw4hQH3shU81dr4aTGPcJzxnCzJBK3vG2wLOQ4SoIFrh+7cNz2iLOg7Pc5zcZH85ZX9ok
ljjKwJ89Ws/ZIXR1xQu5+/BLus5zOcZUAcVOD25s8stAcXFC1gjIpbb+qVStnELjicD+4pru
cPcOPlMZm2W45iDhplmIdvsueLSIpxxeg3+GJSJeIpIlYr1AhHwa68AemS9Evxr8BSJcIqJl
gk1cEUmwQKyWolpxVSKzVcJWYj+0DJzLJGDiV6osG8t4T0lgg12LY7JUxtdqobNxie3KT714
yxNpsN1xTByuYukS021ANme7KvZTbG06E4HHEkr7ESzMtJIeM7bi4DL7cp/4IVO/5aYWBZOu
wlv7NY8ZVymQHjxTvf0CwYR+yiImp2pc6PyAa/CqPBRiVzCEnh2YZtXEmouqz9T0yAgPEIHP
RxUFAZNfTSwkHgXJQuJBwiSu3VFwnQ+IxEuYRDTjM6OIJhJmCANizbSGtiJfcSVUTJKEfBpJ
wrWhJmKm6JpYTp1rKrU2D9khty4O28Df1NmS1Kl+NjByWtW2Yc0F5cYwhfJhufauV0zBFMo0
QlWnbGopm1rKpsZ1qapmpb1ec4Jbr9nUlOIQMlOiJiKuy2iCyWKbpauQ6wBARAGT/UOfmc2F
UvbY3Hbks17JNJNrIFZcoyhCLQaZ0gOx9phyHqQIudFHb9KurfK32HpsDsfDMKsHvNgEahHE
KAh68GKFxxCXu9BskDDlhrFxJGHKrZjAW3FjIvTNKOIUD1iZJCmTRaXPR2qpyNT7McvXnsfE
BUTAEV+qxOdwuMzMzmhy33NFVzA3jCg442BqzTarEHXhr0JGeAs1v0ceI5yKCPwFIrlBz4nM
qdcyi1b1BwzXow23CbkBVmb7ONH3Omp2sNQ81yc1ETLyKes64aYkNez6QZqnvP4sfY9rHO2M
LeC/WKUrTllUlZdyDVoeROAxsxXg3HzQZyumO/T7OuNmsL5ufW480TjTxgqPuBYGnMs9v5cy
sadSJGnCaH2n3g84zeHUw2PmLn6TKlXUz3livUgESwRTco0zTW1w6LpwrYDlq1Ua98wgaqjk
wGjdilLiu2c0dcMULEUOTWwc+VOBOQn5VzMA1TwmuNm62E1XaqeH574rbfuEiZ8eF9w1p7Ps
i/Z8U0r0fCsXcCvKzlwmZZ3Qc5/oJ9O1l82//cm4VK+qJoPphjH5mb7CeXILSQvH0GCrdsYG
azZ9yT7Pk7y6gYr6aG60X6h9KUu3jWVbiM6FJ8smhsm48Ndld33TNLnL5M10lmKjQv3MhYXr
DQ6RteVVeejDyBuuwCjzG3dFu+6v6Yf9w593b1fl89v7649v2uZl8eu+1M4snByBWVnIwxEP
x0xhO7FSq3KSO3n37e3H8+/LeTIXVpgOqASkcWGzIwrGSH1Rt0oMBDKvsA4+nE/dizkTQmxP
Z/jQ3IjbxnbcMlOTzYt5x+vu/f6Pry+/Lzqal822Z9IfNzIWiHiBSMIlgovKnAh/DMO1vL1+
wTVDfnkvCzA3At0+A1ep5sSIJ2KPIcbriy7xpSw7OCVzmdGMlauIGwbsDnGf+ClXjHE2dhmw
MwjhYKfr2fJrMxiGgBUwGOoyuQDXRUxMYGTD4KNFEBvRoZBCgmtEa1ipynqldC+MlknoeYXc
YNQYZmBsk6kFcpiSz+tdq/oSwuDKogimdCYbg3/+evf28PXSFTL8phM4e8kYmch7Y0s8ncr/
h2hUCC4aCc4PGynLTTU/pSNfnh/v367k49Pj/cvz1ebu/r+/P909P1i90jaPhygktk0HaAN2
dcgQWerHReHtZDtJlyXxwPv2WQmv4OQ78gG8XvhBfBNN0LJCNx8BM/fu5gfs+ehwIJbDJxNK
MIRTu/qtwvuXb1dv3x/uH397vL8S9UZc6hY+IlE4ValRU/CsZHKLeA6W9qUeDV8KxxM7eDI+
qw8LrFtuZFiqr8P99uP5Hp4En150cefobU4mFEDcY26NynBla/UThg6etMUttfLSIUUfpCuP
S007rthWxZDZEn2h9lVmLz+A0C8JePYCSgfXp2ccRvz4b5l3IixwMTR5iRsKq0/NBwa0T7wg
inECRTFYuJMkPR2YsISJ195DHDF0BK8xZAoHCBwBDLQOR9DN50Q4GQUnsWqKEbSN9mWiFpW6
QhwijgdC7Hu4VSTLLMSYSg7Z5YGvq9I27QIAXxMER0haeXST1sZ/Wd3gt74VQc3/ADPuJT0O
jBkwoaLnnruP6GqV0O5hUNvM74KuQwZNIxdN156bGBjQMOCaC2mf62uwT0In4KRoXeDiy0B8
5EFAziwNcFAtMOKaXszuBJFUzSge/EYbRGZo0cq3KwUXQ0Ab7OWAB2OD4oP7OSR+KAxQagGq
wevUI3U66ncko0XGZb+MVgn10aKJOvZ8BqKPmQB+fZsqKQxoaPvKgNgMsVN/YgP+fXiw6Ulb
T4auRpvp68f715eHp4f799dRswFeLfzGB7uYVQcEIE5lNOSMQ9QoADDk09sZiKgVr8GwaY0W
Q2LYC3YgvmfbrRibEeQb2nGWq/PjGO1e0LXHoMjaxEJTBkXmvTOKrHstNOBRdxifGafGFaOG
QXvjblqJuJI5MeQd28njqPsBvKy9ChmiqsOY9jzOSlrjs031vHWk4bpsmP0hPTjhSwBaU6Bm
6BboVtdEOLWVyWhV2V4adCnrGG3UThhtNG0OvWKw1MEiOjPR/cML5uZ+xJ3M073GC8bGYUy3
0ThwE6XocXj3WOjiNZc+cz8T23IoVBs1VY+O2C8BwKnI0fi8kUd0MeoSBjbn9N7ch6GcSZ5Q
iT2lXjhQkVP7wAFTWHu2uDwO7ba0mINAvt4txmjOLLXBPtgshgqzRRE9HjO2Nm8xRLO+MK4m
brUv0Y0xE7MpUbUXM8niN7YKjJjAZytIM2wtbMUhDmM+D3h+tfw/a113gYljtg5KWa1Dj01G
UUmw8tnmg9lsxSalGbaCtIEpmwlg+KLSGdJizHDLUa7Ki7nYnhMRRXRixKVJtJRamiSLX635
ruvoxITi5VJTK1bIHH2aUmwtuho/5dZLqa2wFYHFjWs04ooZ8ejVDkylaz5WtQrguwpdH1wY
qktZzKZcINAKwsbp6sDitscvxcIQ2J7S1OOlQ1PpMrXmKfuyygWet/k50lkVWBReG1gEXSFY
FFmOXBgZ1K3w2FYCSvINKOM6XSVsC7oLB4sz0/z5VNvLwAuvNMbYT0L2W1erxlwQ8m1mtOeA
LbyrhVOO72euRk44pJc7HNtEhouW84L0d8Kt+cnK1eURR7Rzi6M3Di4U1RYxEy99E/F9zdEF
i7wU+hKQuX9+2ZL89vD18e7q/uWVeV/afJWJGlxeXj5GrHlF89yflgKA90O4N7ocohO5do7O
kjLvFr/Llhj1o+/gsYlumTnnJ2vH4FTmhb7gTqFTVKkl2HEDb0yjV9IvNMVEfqKqtCGMGl2X
Bxg5xGFn36U3IWAzW14X8F7rgXL98WCXR2esLupA/UcyDoz2UgEPQp6zCvlM1ZFtjls48GTQ
vFZ1TnMOxKnW5+YLn0C9ltxnbi0rNCAz4gVXhWlaJrfBh6kEy7kLFksU4LypHyRXgBzQ45hw
4OS4IYJg4KVQ5KLt1RLnl9Rm4NU/2ILWrT6f+ta61znb/x3ddVIAeoO9Aw9G+gEO2719aV9C
LDsNnCEUhg/F/DXC1Zy4gCcs/unExyObwy1PiMNtwzN70bUsU6t14vUmZ7mhZr7RVQMeOiXC
Lu/YoChch3dKy0fmOiYP2A1WZ1z24FoqwF1wiIvVd4Wov6BXSlT8u6Zrq+OOxlnujsJeGiqo
71WgsiPZ29Hf+G2LEdu70IFIAmCqFR0MWtAFoY1cFNrUzU8WM1iCWmRyJIMCGhcDJW5P+9wS
avV4GOz9ET2gw7tlZF67efj1/u6b614UgpqhlAyJhJhejDqhUVW//yaNp0cLqmPkn0hnpz95
ib0C159Wqa1HzbGdN8XhM4dn4D6YJdpS+ByR95lE2uiFUvNJLTkCnKG2JZvOpwJsKz6xVAXP
rW2ynCOvVZT2o9QWA0/YCY6pRcdmr+7WcEeJ/eZwk3psxptTbF96QIRtvE6IM/tNK7LAXrci
ZhXStrcon20kWSCLT4s4rFVKtpUr5djCqi5bDptFhm0++F/ssdJoKD6DmoqXqWSZ4ksFVLKY
lh8vVMbn9UIugMgWmHCh+vprz2dlQjE+cq5tU6qDp3z9HQ9qiGdlWa0h2b7ZN+hVYJs44me2
LeqUxiEreqfMQ95oLEb1vZojhrLTj81kJdtrv2QhHczam8wBqMo7wexgOo62aiQjhfjShUlE
k1NNcVNsnNzLILC3ykyciuhP00wgnu+eXn6/6k/aaYczIYw696lTrKPFjzD1UIVJZg0xU1Ad
yLOf4fe5CsHk+lTK0lX6tRQmnmOZj1mR2bs+iKPwrlmhxzBtFB+iIqZqBNK26Ge6Mbwz8g9q
av/nr4+/P77fPf2HVhBHD5n42yi/yjJU51RwNgRqJT0swMsfnEVlv5yDOaah+zpBd1VslI1r
pExUuoby/1A1sIBAbTICtK9NsEAnJ3PgcqM1FS6eiTprg+7b5RAZS3krLsFj3Z/RqexEZANb
mnqNJrdL/LuyP7n4qV159pUyGw+YeHZt2sprFz80JzWSnnHnn0itgTN43vdK9zm6RNMWna2X
zW2yXaOnaTHurE0mus36UxQHDJPfBOjscq5cpXd1u9tzz+Za6URcU2270j5BmTP3RWm1K6ZW
imx/KKVYqrUTg0FB/YUKCDn8cCsLptzimCScUEFePSavWZEEIRO+yHz76ussJUpBZ5qvqosg
5pKth8r3fbl1ma6vgnQYGBlR/8pr0sm0oJ03x3xnbzVcGLSKl7U0EXWkX2yCLBht9lp3yKAs
N34IaaTKWkL9FwxMP92hYfwfHw3iRR2k7shrUHYQHylutBwpZuAdGT2Qj+a6v71rf/tfH357
fH74evV69/Xxhc+olpiyk63VDIDt1Yq022KslmWA9GSz5NSbdGQr1eyi3n1//8FtpI4zclM1
CXLFMM4LN4kz8QGWODX5pemEowRo8JxnoROxYUCl8lxFwJCb45el+NyMGqaqK3uR6VDd0ofi
JJPitpBspf18N+tqC9VXnnpHgwSMlZ7thg2/L4byWJ93RV0enL3ckSQekQ1XD+5mcR/6Wv9c
LMzPf/z16+vj1w/KlA2+0/SALeoiqX3de9yBN09SZU55VPgYXYJE8EISKZOfdCk/ithUquNs
Stuo0GKZ3qvx4qBvu53a0LOfPbdCfEDVbeFsrW/6NCKDuoLcsUgKsfJDJ94RZos5ca7iODFM
KSeKV7c1m7ilazaiImOKpT2DN0ZhHhEgOqI4rXzfO9vbZxeYw86NzElt6QmI2QHnZqYpcMnC
gs5NBm7h6sUH81LrREdYbtZSi+2+IUpHXqsSEsWi7X0K2LZs4gAv87iFNwTG9k2L3sjWxwRw
e4zkIqf3NQCVdYmf6hkPGY4tPD+BBSmqZi/A4y0DZx2aiW1xzrLSEc1cnMqDqrJTW26VIi1V
RLcfhslE2x+dMxlVl0kUJSqJ3E2iDuOYZeT+fGqOFK3DAOygLGWmycbDRQ47y0yoISLrbCss
i3YdJJtk9EVLVTCKm7sL6NHckaijcKXUk3brlJ66IbbRc986o9DInHqnSnp4PqHCjTsf3vFt
eznb00+OVehW6zSO1PJ4UNUSt+dd4AzBNv2JGTRtvnZ3KuohULpWLVp7+x9/Od7A3ElXBlSJ
NyB4nHAUjnBM19I+tYvUSbbOXNaD9DrVYlDnDFZVuXYzuVDfpxJ5E7NAfbynHyBLIkqrNqIj
ktNljZJqNAClndZ19jNczJpehLHNrpV+DxRW8M0B+Xy+SPC+EPEK2W+Y8/QyWtE9T4pdQtKt
SYrNpaKEeXoHY5doE5KBukvpvnMuNx39VNV3qf9y4tyL7poFyT7idYEGZL0sE7DWPpCt1lqs
kZXOpUrt+RnB56FHN7tNJtSUvvKSvfvNVmnygQMzltOGMQbYvyze0AY+/fNqW4/Hx1c/yf5K
33y03rO6RJUOrgBuH18fbsCJ709lURRXfriO/rGgWWzLrsjpJswImq1dqo6anUrrLW+d+P3L
t29w781k+eU73IJzlo+g4Ea+M972J3rknt22XSElZKTGj8xQveEDjYI10dCaWZQswOeT/SgG
9NVSHJS4ohq64F3GoTpdd0tZW22YOcVS/+6e7x+fnu5e/7o8a/b+41n9+19Xbw/Pby/wx2Nw
/19Xv72+PL8/PH99+we13wHjle6kX7iTRYWO5sYFRN8LWzMbl1bdaGJu3rN6vn/5qpP9+jD9
NWZA5fHr1Yt+C+qPh6fv6h94XG1+qUP8gLX45avvry9qQT5/+O3xTyR0U5OTCwsjnItVFDq7
CApep5G7ri5EEvmxOxcDHjjBa9mGkbuhm8kw9NxFkYzDyDl8ALQKA3fntzqFgSfKLAidlcIx
F2qh4JTppk6Rz6oLajtbG0WnDVaybt3FDhhkbPrt2XC6Obpczo3hbFAIkZg3EnTQ0+PXh5fF
wCI/gftDR5vSsLM/AHDiOSsegFO38Grp5julVGDsdEwFJg54LT30xMXYvlWaqEwk/GrM3bQw
sDsagbH1KnJK2J/a2I+YwUvBsSubsFntuZJ8E6RuLfU3a+TA2EKdsp/aITQOEq02hI52h/oh
0/Qrf8UdmsSmZ1mxPTx/EIdb7xpOHVHWgrLi5ccVfIBDt9I1vGbh2He0RZGvw3Tt9EBxnaZM
O+9lalyO6aJnd98eXu/GMW/xEEtNegdYmlQ0tuYUJLEj0o2SR3fcAtStmOa0Tlw5OskkCRyB
qft17bnjpIJbZJk6w73ncfDJcytRw27csvNCr2U2IQ9Nc/B8lqrjuqmciVDG14lwd2EAdRpa
oVGR7dyRL76ON2LrwtkqrGflavt09/bHYlvmrZ/ErmjJMEGXiQwMt+PcPVaFJlqZsHrP4zc1
A/7rAZS5eaLEE0KbK6EIfScNQ6Rz9vXM+rOJVelX31/VtArOBdhYYWxfxcH+svv6+Hb/8ARe
LV7gNVo8c9OesArd8aeOA+OT02iXozLwA1xwqEy8vdyf702fMZrLpA9YxNSZXJc38yq/rAcP
eWC7UFrIkfc0zGFnqYjrsQtlzPm2XTfmTl7Ac9C9kQ9Em4qxG1SbIo5QbWqFbgghar2c1nq1
QHWf4ujAFxomEnTxUWuFk7mxGf1+vL2/fHv8vw+wD2kUUKpm6vDwCmuLboNanFLT0mDNJ2RI
dG8Xk75i/UV2ndoOTxGp12xLX2py4ctalki8ENcH2NsF4ZKFUmouXOQCW5chnB8u5OVz73sL
zXceiEkZ5mLPPdyauGiRq4dKfWj7sHbZlbPIGNksimTqLdWAGAI/cQ44bBnwFwqzzTw0Vzlc
8AG3kJ0xxYUvi+Ua2mZKa1qqvTTtJNiBLNRQfxTrRbGTZeDHC+Ja9ms/XBDJLg2W0lPtFXq+
ffKJZKv2c19VUTSfDI8jwdvDlVpQX22nVec0uus7JW/vSuG8e/169dPb3buaYx7fH/5xWaDi
DQbZb7x0bWlGI5g45gpgdbf2/nTAROnuBFWVnMvQuNzksnV/9+vTw9X/unp/eFWT5vvrI5xr
L2Qw7wZiOzKNRlmQk0MUaJ+EnDzUhzSNLhs6Cvqn/DsVo1TvyDm90aB950qn0Ic+OQL5Uqnq
s/2yXkBa1fHeR4vhqaqDNHUbxeMaJXCbTzcK13yeU5Wpl4Zu/XrohtgUNKAWGqdC+sOafj/2
h9x3smsoU7Vuqir+gYYXriCazxMOXHHNRStCCclA05FqnCbhlAQ7+Yc3HQVN2tSXnh1nEeuv
fvo7wi3bFF1ln7HBKUjgmHoZMGDkKaQnct1AekqVROi9pUs5IpL0YehdsVMiHzMiH8akUfNy
A5VITd8mOHNgeFGrZtHWQdeueJkSkI6jDaBIxorMEat9HqwrWpuq04SJI1V5oAb0jkEjn55M
amMkagZlwIAF4cYdM6rRMoG10Hlb2DKXjQProrRBb02pmJs6C1hZoCOdGW1W8wKolyrNw8vr
+x9XQq0oHu/vnn++fnl9uHu+6i/S/3Omh/u8Py3mTAmZWusTyWu6GPtNnkCfVt0mU8s/OuBV
u7wPQxrpiMYsajtvNnCATHjnDuaREVcc0zgIOOzs7N6P+CmqmIj9eRQpZf73h5E1bT/VPVJ+
9Ao8iZLAk+H/+P9Kt8/AbcWsm0zmtNanain69Ne4Yvm5rSr8PdqoucwPYNjq0WHRoqxVb5FN
r1NP+whXv6klrZ7lHT0iXA+3n0gLHzb7gArDYdPS+tQYaWDwShFRSdIg/dqApDPBYoz2rzag
AijTXeUIqwLpDCb6jdK66ECjurFa4hLtrByC2IuJVGq9OHBERhuJklzum+4oQ9JVhMyaPpjH
o/7l5ent6h02PP/18PTy/er54d+LGt6xrm+tsWz3evf9D/CS5Rpt7QR+v3wE9AHxrj3KX/xk
jtk2TVA/znXZlmpSLzGat6pDDvoBMnRDArjrWp73RYWtTUZ8u2Gprb6ozLixBhKM+M9Ku8+5
gzPF9z3J8q6oz9pj5kImEDe/wzzuD8Pjqvy2EnwO58bONu1EZHs14yYuLssKmU1N+GFo9S7A
Oh1IifItQTrfXg9rROQFrSmDaZdFbU8KLup8Z1spXLBzVl6z+AfxnHei690zwTGA8Vg+Gu9M
vr6vfjJnatlLO52l/UP9eP7t8fcfr3dwsoqrGuJRn+HID83xVAirGCMwHovGLDw5fv8lZKLS
739W5W7fE7nfCQycSgJIcUJ+pXSgXUGE8ZhXpH6km9IOvRICYFZ2arg4f1Z9AhOfBxLfpsn2
kma16+HVddrerTgUs5/y/PHt+9PdX1ft3fPDExFzHdDZFbOY0ZCmytfoXc1LiEqRuyi2Xd1c
SPV/Aff8svPpNPje1gujA60AnJBMilQIPoi+jF199j2/8+Xg+R8Ekl4U9n5V0ECzzRuqmYuj
wc3r49ffH0glGR8S5aD+GFbIaFOLl+rcbX8Io8TJNXTTcyvTBE2N0G4ZGSVEl7W745Sv7evd
t4erX3/89psanHK6/7+1BvhpoNTDpgUrfbvO4c0xhB2avtzeIii3zePU703T9KAIMw41INIt
WFdUVYeO6Ucia9pblRXhEGWtus+m0tf3Zod7I9ep6aAth6KCa83nzW1fMB74VDh5K/mUgWBT
BsJO+cJsm64od4dzcchL215dF7/fX3A7sxv1jyHYpydUCJVMXxVMIFIK5EACmqDYFl1X5Gfb
oAACq9m7KjckH7UAf7SF5BNgxjj4Rn0wToQ46b6sdPX05WHHCt8fd69fzdUFeggC7aeHLhRh
Wwf0t2q2bQM2ngo9OHJTtRKfYgN4uyk6rGvZqCOzQs27qspxzGUte4wcQawR0rTFAYxqcRmk
nxNHx9B1TmVeCgbCjg4vMDHfuRB8E3XlSTiAE7cG3Zg1zMdbogMXLT/4pfYZUgpgVRWH8liz
5K3sy8/HguN2HEizPsUjTgXuclS/mSG39AZeqEBDupUj+lukU83QQkSiv6W/z5kTZH6Po8py
lxsciE9LhuSnI9tU95ghp3ZGWGRZUWGilPT3OSSdS2P2LTiQ16JRw2eJU7m+7fAoFSIVdgSY
XGiY5vnUNHnT+Bjr1XyJ66VXs3ZB+jcytNQjDf4mE11N578Rg/dc6nNx0laS89iKyOwo+6bm
x1hwE4uzV4P5K5SYVDx2u6wRmR1JfSG9EXrsRi1shj6KSRO5r0VDZRnHprinFaqnHZqa9NWN
qlYyqI2YvrywI4I3cbTJNp1apcl9UZDmODbna3/tDSzqsSipG6KEAiTVSGxfT9FVuLJPE+Z+
BR3R1VkANE5TjPMdzFTR1vOCKOjtEz9N1DJIw93W3r3QeH8KY+/zCaNq9lkH9mn4BKK3GAHs
8yaIaoyddrsgCgMRYdi9P6ALmBRJWJNYqXIOmFKnw2S93dnL1LFkSiivt7TE+yEN7aO7S73y
1Xfhx4GQbRLik/nCIN+IF5h6gMVMzLa745/TSqVO15F/vqmKnKOpT7sL4zxJgagUucoh1Iql
XI//Vi4dh5VWlNSZL6rcJLRdzxBqzTJtitzLIgb5b7XyJw5507EJuU4fL5zrENEqFvEpbEkT
fqfkkr2Tao9V1XLcJk98dIltp5beoqf3LngteJ/X8yM92cvz28uTUnbHdeFoDs7us6k/ZWOP
VwpUf5n3sGQGTvywFymeV8Pel8K6t2E2+5zIEaz+rY71Qf6SejzfNTfyl2DeI9mqGU2pRdst
nC3SmBlSdfZeKerntlPrp+7247Bd05OtPLVWbvAveP36qHQ/dLvBIlTV2IeGFpNVxz4IkIHV
8ZCTn+dG0stxGFclKdQwVtoPIKFYDtpXvL2FCFCb1Q5wLqrcBcsiW8cpxvNaFIcdaBROPPub
vGgx1ImbWi0PMJg1tblI0Gy3sDmK2U9IvCZkdGiDNmuBk4XS3g8ZLaOCjfBgWNUcbNJisFbr
9A4otwKWQLgAqeqAIZn6nrPoRrfv+PATMe/84Sagzg3twogBVL5c/hIGKFKjQpyVtoUdauqM
d0123pKYTvBsiSw0ucyVh560FlmqzND0kVtnQ3d0Vjg6lVoNeLR2RomCWiJt21ah6l6bkZkV
4JGLJo7d59BVtBE3BQ1h8UpyfO/ad1Ou22Pk+eej6Ho+S6RYg4uBKyHqO1LXHL00p0FXsAW4
9yPJlJ3b9eq+FScKSfT2tJbArhTV+egnMTKUnMtK2lAJVi0OwRAxhTKPf6pVXPEhOUu6h6WD
5F/kfmr7XDdll2jdZ7AyjmKSTzWgl0PLYXoriYxm4pimPo1WYQGDhRS7CQjwpQ/DgAylmx5Z
fMzQuVFtnsHba2TcFJ5vK74a0zebidgNt0p7dYXM4OR7GQWp72DIkeIFU4vnm3MuW8rFcRiT
q0Oa6IctyVsuukrQKtzp96ExVolbN6D5OmK+jrivCVijpyDM0E+AIts3IRmGykNe7hoOo+U1
aP6JDzvwgQk8jjIsSIMepB+uPA6k30t/HaYulrAYvWFoMeR6KDDbOqUDgoamG7Kw905m3L0R
IXNY8fL8P9/h9P73h3c4Ob77+vXq1x+PT+//fHy++u3x9Rvs05rjffjsYtZO4iO9V63qfLSi
nkEqFfqhtHTweJREe910Oz+g8VZNReSoGpIoiQpnci5k3zUhj3LVrnQTZ1Y51EFMRoE2G/Z0
nizbXi0PCFgXYeBA64SBYhJOn3edyg0tk7OJZeYekQZ0CBlBbqzV+z2NJJJ1GoKA5OK23lqv
j+7zf+ozWSoNgoqbMO3pwozKCrDSqzXAxQNq6Kbgvrpwuoy/+DSA9sXhOPWbWD39q6TBs8z1
Em0O7ZZYWe5qwRbU8Cc63l2occHIcvREhLDgMldQEbB4NW3RiRSzVCYp6045VghtOL1cIdif
zcQ6uzuXz7rCRVX6i81WDNR/y9zc0JZqGqeLYd2dqA4u+lWYBX7Io+dedODNZVP2HWwBwEvG
SFNCzsdGgD4/NsFH4dMRW3tuE6X4vABzYxOQCVxKd+F9uUV+M7Rqk+X48GsKDOe5iQu3Tc6C
ewbulQjiHdKJOQmlypKBCPJ84+R7Ql29KS9pWZphe4ORUuJTkDnGprsmPWdTbJrNQtrgfBFZ
RCK2FxK5YzXjcuYARrne0C4LzHS+88EyXt9RGpfoTNR0STGCZzGU5zLgv9CkbPNyy9DUTsbI
fW1eL12Az22+SEn5IZ3X4qMvP6YptfYNI+r1LvDMRXFn1TF9D8+DeHSNZEcxxP8hBr1pnS/X
SU2HtE1WB2kYa9ppnKJdw7PnppZHl37Z6DkA9K3t68PD2/3d08NV1h7nuyaZ8SlxCTq6lWA+
+T94YpZ6l6E6C9kxMguMFIxwaUIuEbxQAVWwsZX1oDcdnHaeSDVo1keqq9cL1TTuoZKyP/7v
erj69QUeQmeqACIDUUgcDctwhUydpeLEyV1fxc4oOrPLlSHMzcOObrZ9iVaR53a0C+6KjcV9
Ls/VJiG5uS6765umYYYmmzmLrha5UOuXc77hirNjQcjOuTwscw2dpiYS7JaqSnWVxRC6+hYj
N+xy9KUEfx5lo1XNTqlparXKiPln9Lz3hFYtnEZltsEbptxzM8yX7efUS4YlWgDtJy4tezbS
MfxZbpgidE12rUraMrGVHSN/gHK6CObO7gQ+BzhS/c9kfV4IiKenfz8+Pz+8ul2T9L/jISq5
jTZDLHSgod+2O8HPbtqidlbozAgJ0TP3q6e6rSqTAyY290Bt/oo+ZTkRN/V5f9wwcSlCOIqz
jmqTmoeO3VqYdIclLvfTkJEiha9DLtMad5Vdi8OPHVtcygxyIl+F6IWHCyGOfrgKF5gV1Xcv
zLDIJB8wS9ke2YUCA0s322zmo1jTj2Jd229NUubj7xbTPKWsGGqCL8MJXTG+ENL36T6nJq4j
n6pDIx7bHqptnK7lRjyh66YJj7icAs7MvYDTjTODx2HKCX2VxcikBxF0TavnXxnGFU9EQUW3
qy2CbyRDLkbHZFkTXC8BImHqHHC6wzjjC/ldfZDd1YIUAzcMjNIzEosxhtGaxfHj0zMxBF7E
tf2o0ywMexVTY7lYBXRXY8aXwjMF1DhTBoWjF0UuOH4ZeMI3cPzOTLDumgBQ2O1ZKu2S/mlw
viVGjm3bHbzAwMjKXulHzLaTnlR1y3I9pTyAh7fr0OOmoVKKTVFV/4+xa2tu3EbWf8W1T9mH
1IqkSFFnKw8QSUmMCZImSEmeF5Yzo0xc67FnbU/Vzr8/3eBFuDTkVKUy1vcBRKNxv3VnRAny
5XoZEsXC2QlGmpjI7sCsiSIeGaIQJBOEK2KYllREdNOS0G76GAyRUcmYR3NyCZhwL6KGGCRW
a6I+jQRdrBNJliuQwWJBaA4JkIJQwsQ4UxtYV3LoPZ7+auj5/3MSztQkSSbWFNCzE2oEPFhS
xdu0PjVGALwmNNS0YegR/RPgETVLR5wUB/AlUQ0kTtQoxKlhRuJEJ4Q41f1LnKjLA06r1L10
NU2WXvAdp2ewE0OX7Mw22U7z40gsOhx9oGMhIAT3Q6oXR0LzSGcQDpWMJJ0LwZch1WHAOpMc
GRCn+gTAQ58oXFyvrlcRuSiEpRAjlhQtE35IzTiA0L0Lq8TKPLiUxJat4xUhlmK18SpJa00N
QOr8EoCSdiJ1V0Y2bd110GlnXBjyAipbImC+vyIGLst3sUJEC6rtD5YtCQkkQa2qZtu3Jo6G
vqjw3EOvU9mB6EmO3N7kH3GfxnUPORpOVDTEaZlisvKbzpoVPHR8J6QqHuKk7ni8ohakiPtE
45U40YFQ+74z7vgOtbhB3KGHFTX/kQZPHeFXRAtBPCbLJY6pxdyA02115MhmKvfKabnW1CqT
2lufcKqVIE5No+XGrCM8tSHg2shFnFogSdwh54quF+vYkd/YIT81m5WuyR35WjvkXDvSXTvk
p2bEEqfr0XpN1+s1NWM68vWCmtciTudrvVqQ8qytayEzTuQXFg5x6Ji1r8zrM/PUnJob8cQL
VlRR8sKPPGq1WsrrZkQm2ppFXrBgZj7kUxNzl19eGcY7z8roopwPDhcp8tTeL92rT2/hR79h
bZs199LPcrlr9xqr+UTurLiXA/fhBOX7+TPaCcGErY1SDM+W6PRM/wZLGvVgZob67dZAa+3J
zQypnlokKNQjUol0eGZvZDsrbtVDgQFrq9pKN9lnjXqxfMDyRPPvLMGqEcyUpm6qNL/N7g2R
zAsOEqt9zV6mxO6NE1sEoVh2VdnkQnsGP2FWBjI0cWFiRaYdWQxYZQCfQHCzxLnuoEiC28b4
1L7Sr7sMvy0pdm0UB4bCIMm26sxacntvFH2X4DP3RAePrGjVG7MyjfvGuPOPaJ6w1Phie8zL
PStNaUqRQ7Mw4xeJvOVqgFlZHQwdopR2pZ/QXr1WqBHwo1ZyMuOqChFsOr4pspqlvkXtYIy0
wOM+w/frZknIx5O86oShFJ4nTYXPQAy4wuMws3LwrmhzovDKtlFvXSFUNXr9wJbCyhaaWlGp
1UsBLZnrrASJy9ZEW1bcl0aXUkN71V6/KqBmpEDFiXewKu38XpGlgmYSq3soIIMN3sIzY+B7
FiMTTZUkzBAGehxLk6N9CgPU+itpzt5UqKizDA0xmJ9rscpAR58ZMloOmqWQ6tafbIBNlpVM
qL3dDNkicNa0v1f3+ndV1IrS5mabgz5AZJlROO0e2jE3saYTrfkgQUWt1I7M6jePea77HUXw
lEPl1KFPWVPp+ZoQK5VP97CmbMxOR0BnVDV4MEjiwzvg8dc0JqPjRnIiMNzosmqw4YYewOF1
zmyRiPwYnpfuzbjVPsl1QxM6bz2AlRfTDOfM8sZbgx0iE/0+0ZMwgpUldAdJNtxnl29AHRa6
USmW35TBl6d8r9Djs7tcGKK5XujIvLa7/riHplhY0ZCSnv2Q0gtP3tsr6ly/1SVd6Zg6OFrZ
PUp1aZbZNXh+fHOpBy9v7/huEE2sPaG1FnOOJqNGq9NiYam6P2Fp0qj2VuGCWpcbZoq3txR6
AIEJHL2Q6XBGyiLRBm3CgJL7tiXYtsXKIWBKR8W18jGl48hLdep8b7GvbVFyUXtedKKJIPJt
YgvVBD5mEzAKBEvfs4mKVEI1i2xmZmaEWZOq69nsyIQ6vMJroaKIPULWGQYFGE6jmhjN2sHK
xYo0OSuDv/d224fmRom1PzICTOSlOWajli4QlJ7N5GVvtzxquxqsHt0kTw9vb/bCR3ZNiaFT
+cYuM6r1MTVCtXxeW5UwwvzfjdRlW8FcP7v5cv6O9vfQQYBIRH7zx4/3m01xiz1fL9Kbbw8/
p8t9D09vLzd/nG+ez+cv5y//vnk7n7Uv7c9P3+Vlt28vr+ebx+c/X3Tpx3BGkQ6g+cRPpaxb
71o81rIt29DkFiYI2jirkrlItV1HlYO/WUtTIk0b1danyakbRyr3e8drsa8cX2UF61JGc1WZ
GbNhlb3Fu3I0NfnkAhUlDg1BXey7TeSHhiI6plXN/NvD18fnr7TvZp4mlgs5OeE3Cy2vjcvw
A3agWiDg+8oYAzFsp17eHTCi6nDZBlN5lXR+x3kh4MPkS885xI6hf1TireccIu1YAaNEMRtW
q58e3qHyf7vZPf043xQPP9WHSHM09B8eaRvnly+K2hy9ZUmcQku5si/gQRCilcpcvs4epiey
G+EMWuCXs+INQnYVeQU1qTB8bKfHJLAROZswVSeJq6qTIa6qTob4QHXDdGLyjWdMrDB+pZ3b
zfDg+JIgrCFMoriZgk8DLMonMu5bGR/Mkj58+Xp+/1f64+Hp11e0ooB6v3k9//fHI75Lw9IY
gsx3gd9lD3p+RvPHX8YLgXpCMGfMa1irssKtQ1/TofUFIr8+1Uokbr28npm2wbf1PBciw3Xf
1tbt+FUpc5XmesvEqgkLgYzRaF9tHYQl/8yYjf/CWH2FnCKtogUJ0hMqvJw3pKCVyhwHkpAq
d9b/KeTQBKywREirKWCVkRWFHP87IVa+OWTJ99gUZhu+UDjrkZPCmWaJFIrlMI3euMjmNtCs
8CucuVGqirkP1NMqhZFLoX1mDcUDi+9hBhtUmb0AnL5dw2zYdLk6UuPoyGOSznSf5gqzbdHE
QF6R5CEfVs02k9fqCyqVoMNnUImc+ZrIvs1pGWPPV69IqSUvjX45RDzSeNeROPahNSv72pq6
aPzVuLymsz/xnWA+XUJaCLqM9SBXhRzDmPMkK4xnzv3sEB8L461pRWtB7v5OGLr4lTDLj5OC
IAXdE9wWwpFAtcmho0jo2smTtu9c9U/aaqOZSqwc/dvAeSG+1HA2CgyjOR1VuVPnjFeyA3fU
0rrwNT9rClW1eRSHdNW8S1hHV4I76PFxc4rueOukjk/mAmLk2JbudZEAtaSpuRkx9+ZZ0zB8
I1hoR0BqkHu+qegxxNG/SMukujUehT3BKGEtu8Yu/ejQ9OCdmKZ4mZcZXXYYLXHEO+EeZs/p
iMdc7DfW/G9SiOg8a204FmBLV2trm0zfKyTH84znkfE1gHxjBGVp19q16SDM4QnmYNZSoch2
VasfMUnYnP8UZuWZRsfkfpVEgcnhYYpRvnlqnPsgKIfKrDCLXB64oif6wYq6mq9cwD+HndlV
T3BvlXVhCA6z1jLJDvmmYa05EufVkTWgJgPGjRqjFPYCJnByA2ebn9rOWLSOL3q3Rs96D+GM
cso+STWcjFLeizzBP4LQ7Fzw3AQtlEhXeKZYyZ5VQjtMldpszaaGBzDElkFywiNxHesytisy
6xOnDndAuFqf679+vj1+fnga1rZ0ha73imzTCstmyqoeUkmyXLE4NC1pKzzLKjCExcFndBw/
gwb0+oO2+d2y/aHSQ87QMJPf3NsGtKapebAw5qNccNyA10F8rdfHJy/SMye1irvxhzw72mPO
sDigMGqJNjLkIk2NhYbCM3GNp0nUWi/vZ/gEO+0SlR3vBxt4AsJdasT59fH7X+dXqBOX4wC9
Qkz70dbKbdfY2LSHa6Da/q0d6UIbTak+Mc19pSzIg/0FxAJzuxwFMRrtJk3GyPquBblTgYGt
hSzjaRgGkSUBDG6+v/JJUH+MPBOx0dHvqlujZWc7zcOgUqynHHoZQzGDNUVrXVzkG3zuX4m8
NWpf12c4Chj9fZ+ZW9QAZRYkuo0wG8G2b8pU2m3WFtXDn1vhXHXj6aeTlBe5HYvwrDX6RwBm
GQx4yIP2aejGEu5MeFD1FbG3XZngjOdKEI6vc6fd9esJjTZA3KHGaYo7LbSbZ+/dGR8Zzxuc
IZJ0MA8h68uV75TVbc6u8Czh0OdeCSDviFzh8XjZzaabXX2FPmabhFGWsMeZUq9fROmOG+0H
Hh7pAJ4x6UjuLeOF0mC56vgOfphjQX1s0PRjpoUbwXm7ZtgD5sm/RAr/Qb1P0LWmdTyLn9/o
FuRmaDqVjm1mI0/FL3EwBcOuIQYeZy2WLB+eGmNkkWqamqF+tDYuhHZkfuFrM1oDq4K9rdYx
dNFuOUVU2541TKjzVZ1s1fuwF2qL/6o38RXJ0UamTuAGdr838tHmW96r9jsQtA2gyw/XRmaT
zcozEj/kDL5mV6uj+ZtSBqDmbvoI3wZ2fKvEpN7VJzJSoG6jWWJErBP7xETSfR7B7M8IOZ4B
EuU8EtpUT+qzEvt8w+wY2q0BnnEBC0gC0Rd0/Pzt5fWneH/8/B975jtH6Uq5GIeFU6feqOUC
6oDV5MSMWCl83FamFGWt4YIQ/3d5BFf2gbobNbONNru5wKSaTVbTNd6S0W+q4a/BGg2F9Vv4
/37KNeC2PmVg29qBhDcJj7QXqBc0NFFpi31BgYENas++JVgnbB0GDtSw2i0pAirqYL1cWmAY
nk7WHaWZU30FXkBLZgAjUzo0dr6wo+t2zidQs+l+yVxo6hzRKDDRwZQ8vhRrO7OkzRc3EjQt
3c9gaOYiZYnnL8VCfcQwSKLa0JdIk+3QsZ66pB9qRApTZEs7bRCuTT1ahu8lat3Il2ibsChU
7a4PaJGEa+1R2PAJdlqtIis9abx/bX4Dq6XqlVGCVavdUBiiZ+XW9zZqxy7x2zb1o7WZ41wE
3rYIBnuLRouTdzX+eHp8/s8v3j/lgq7ZbSQPM58fz+gvkLiKf/PL5RrkP402u8HdC7OExD26
QVKTb18fv361WzzOqnaaQWMVNq1na1wFa0DtboXG8jZ1MPsM5i8b7YBJ44mruxqvGeXRGKIv
mKjpduBFKY/f3/FA+O3mfdDMpQDK8/ufj0/v6LBRehO8+QUV+P6AFlFN7c+Kalgpcs3upi40
A0UyB1mzUj0VHCZd+QZWjKqPIOZ59/2mYeg+yT5mzOH/JYy9qr35C9aj60VoBVfIIdUrkdUV
pUJKZ0gc/6rZLlevLiuBWJqOOvqAnpeeZDje7hPmZswJvMLfqTYEFTw57dQtDJO58kXklyST
Lxe5OuUrTkuyeIAIPyq3MqM1AfgV2aqk0XYwVOHqyqEKyfQJXcoD6U5R4eX1MDKQaGoX3tJf
FWrvYxB0FMz4QaEyNGphXVfONFNgMkyR7Vhyjz2nWvkkZWRbYpxTH0FHdwZ0wlP/C9a0iW7Q
EgFj4obQPoHJ9D0NTl5y/vH6/nnxDzWAwN1fdX6vgO5Y2qwbgJvHyVGlMlxgwLxst6aGZlxf
c82w5iFCRfsuz3rd+4MUpjlo61m8uI4yWTPWKbA9adUYimCbTfgpU72iXZgTHUMEK9X28YSn
QvccpeP9/qjNNlVWfXSq4/0xbUkuWhES7O95HEZEVswZ6ITDXCjSnvIqRLymMmO5PtKINZ2G
Pt9SCJifqYYJJqa5jRfElxoRJgGV71wUnk/FGAiqsAYmJMQ6IW7DdbLVX59rxILSumScREwQ
fOm1MVUcEqcrw+Yu8G+JdmMaJ5gTZwVngoiAzpPiiKjwkll7xLeAiRcL9W38XFZJ2JJZFLD8
W6s+pCZiywOPkreBVkilDXgYUylDeKqCZjxY+ER5N4dYs402CxrOx2+izq/3O1g+a0d5rh2N
e+HqQgjZEV8S35e4o8tZUzpba9b2LipbOlQZeaTqsSEunf0JkTGo8b5HtR6e1Ku1kWPCbCOW
wMPzl49HgFQE2sUXXQCy+KEk1gkRZWDmfls/dPpACM+n+jXANefuKh7SxRvFYb9lPFcvDuv0
b8q5iMasyS12JcjKj8MPwyz/RphYD6OGGHIgnRg12c7sdgZWziIoehKBbCn+ckG1LGM/Q8Op
lgU41UWL9tZbtYyq48u4pQoX8YAaGAFX7TfNuOCRT2Vtc7eMqTbU1GFCtV6spkQjNV0NqnhI
hBd1pj7QUhqO4SrwMj8KPGruUHYJOaf4dF/e8dm3yMvzr7B6/6AdsUNeqluhM5Hv8CluRcir
306/jDqJDQ42tgmFNkuPwlkb+KxeLchJYbv2Gr72qYwjhybEbca6BTyL0MYh9SnRlSdCH/xA
pDrYcI4JYXcZhzWSjSfVfr3wAmo8Fy0n1FonlLJx7+5EKXCw5EhNTxN/SUUAIvApAibzZApt
tmuIuYW+FpvzVB6IHodXuluXGW+jgJrGTou62ViHOD+/vbxer9nKe99Ws/4BS9bLm1cLM5ef
CnPQVm74CCU1HwsxcV/CuvTUZyXeIcfrTGWJ9umPeaveVYLI/eCAQMdGz79TPF1C7T0BuhQA
LNFDQOWNlFon7cDrexN8h6+ZemPDogUZc8BUV2gcFK82/3JTb8dUL2CNphlUAHS90RFZejok
7xXtMcGe79TbixdCyddRZtR4WDWidjDtYGcvOj3l6S6Nbv9e5iHrN0zzzzegStyENUaiytUc
gxHd+HuuLMnT4/n5naosenbRhY16Le5SV/qG5anyyU23tV9ny49utdbIupN9FVG73Y+mANXj
TATqsfvMmzudSHnGSYKptgQREFmTVOrCX34X/VJbbzOAKLP2ZARtOu0+L0B8G6nGgrDB2G4C
EZX5k5o6PL6CjuyeYgilV5gLNm5RWdQGndqo2wwjbriIGVGuuRVXwD7haEEis9/ff359eXv5
8/1m//P7+fXXw83XH+e3d8Kee2tsANdNLrivH11Cc8rS/Ldv+m+zj5vRYdceqpX02dPfbn7z
F8v4SjBYjaghF0ZQnqNLEbN0RnJTlaklmaz6JjjdiDfx4cIPTAh8mxIwhSlrC88FcwpUJwUa
s7NSBxiqHAlHJAxrbAKOPVtMCZMfib2YgHlAicJ4XYCe8wpUgTl0BIApQBBd56OA5KHW4vtX
ErYzlbKERGEpwm31Ar6IyVRlDAqlZMHADjxaUuK0Phpyp2CiDkjYVryEQxpekbB/smHOYdJr
1+5tERI1hmE/m1ee39v1A7k8b6qeUFsubxD5i9vEopLohLP9yiJ4nURUdUvvPH9jwSUwbc98
L7RLYeTsJCTBibQnwovsTgK4gm3qhKw10EiYHQXQlJENkFOpA9xRCsE7eXeB3duEZE+Qz12N
ycV+GMqBx9Yt/O+IjvLSakezDD/sLQKiblzokGgKKk3UEJWOqFKfaXSP6qb966JJQ6huOvD8
q3RINFqFPpGiFajrCPevHdzqFDjjQQdNaUNya4/oLC4clR4u6XIPb7M5OVIDE2fXvgtHyTly
kfObOHBcH1LIiqoMKVf5KLjK575zQEOSGEoTNKmWOCUfxhMqybQNFtQIcV/KO3Tegqg7O5jA
7GtiCgXz0JMteJ7UQydBiHW3qVgzOAE0yd8bWkm3ePWgk/ZPLC1sMIYc3dyci0ntbnNguDsS
p2LxbEnlh6PVkjuq345C3x4YJU4oH3E8aqTwFY0P4wKly1L2yFSNGRhqGGjaNCQao4iI7p7j
+wHi0zDhh7HHYuSK0TE6pO2amiyWMlZE9YCAp52tkAHeMmJOPVDSVrzFHfhtTDUGGLXsyoZD
GT2+EYPz7fAvHslf63Gu9TZ0g3fWBUeRXOCmhbn22u80RBNw+N0nzX3dwrot4bWLa29zJ3fM
aitRpcI08crzlatWDSwA4kwB8BcMcoa5JYjmB0wNJn/bAUd8g95as5Nme61pYf6inu0e2ihS
C1X+RsUPVwTy6ubtfbSWM6+pB0dknz+fn86vL9/O79pKm6U5TOV9dWt9ggIbWluQuqNZ5CIo
Fn6q+mpNWDCYXR+keH54evmKhki+PH59fH94wptlIKYpE4yJkZoU/u6l69bZW56D1q6nA7NS
T5Thd+zpH/bUW4vwW3vbNO7AAq5uH+FRwQipmZpy9Mfjr18eX8+fcfPHkb12FehiSMCUfQAH
A+WDtZaH7w+fIY3nz+e/oUIv1HPuhXpOV8to3rCS8sI/wwfFz+f3v85vj9r31nGgxYffy0v8
IeLXn68vb59f/p+yK2ty21bW7/dXqPKUU3WSiBS1PfgBIimJFjcTlEbjF9ZkRrFV9iw1yz32
+fUXDZBUdwOc5FY5jvE1hI1Ao4FudD+dRi/6GtiaZ+NZPxXy0+t/Hp+/6dH7+d/T879Hyf3T
6U53LnT2aLrUihhjyXn+8vXVrsXcKoPlaeovxyQeBqFgG+5aIURZD8CP+Y/+86ov+b/gNuf0
/OXnSK8fWF9JiNsWz4kTewMEHFhwYEmBBf+JAqiH+g5E2uHq9PL4HSxq/3ZK+HJJpoQvPaKy
MYjXf6LOVHb0G3CVhzs1zR+QZ6f1qpEZ8emvkOPmorZ+Ot18e3uCxryAf6KXp9Pp9iv6WGoh
7fYlXVkKgHvSetuIMK+leI9ahoPUskixJ2hG3UdlXQ1RV9g2k5KiOKzT3TvU+Fi/Q8VbHiO+
U+wuvh7uaPrOD6nLY0YrdzRgKKHWx7Ia7gg81kREc9nZwA6OFRd+qGP8jrGlRHSAd+BK0F4u
KZjli0WAjZsOSRQXTXa0IFBixFUk8CV6S7maLWbHZod0OWlShfZtrEZX9QKHntFYQl9EAGTv
NqZMIbEVsMGYLyQEGpNeJYYSd4kmQ8KRz0labOzxbQ1Z2x3n7vnxfIf1FVtilizyqCq0K+4r
sFcuqutmB+bSeNJf53hWXTEgreNmE2Xq4IqEzT7eN+/r+qqur+HKuamLGjyXFEpyQYHlL3SI
AdCSJ/2r76zW9i65MWD2l/j1FiIVeZTEcYhbCZ457nFKV1KK67QQ0QdvDDESZoQu43RNr7I1
DDO+waJluodoAvB0nUPFKtK1qNNDnbZP0z+AzMjyGSPg+FiC//UDaBxj/AarzaWnRirUcMdV
RV69RRv8QTaygVivqwK/NFAMt15b6UZsMs+fBbtmnVq0VTSDSGGBRdge1Y4+XuVuwjxy4tPJ
AO7Ir84WSw+bmyB84o8H8KkbDwbyY2deCA8WQ/jMwsswUlusPUCVWCzmdnPkLBr7wi5e4Z7n
O3AZef5i6cSJ/RvB7WZq3DE8Gp+4651MHXg9n0+mlRNfLA8WXif5NXHh0uGpXPhje9j2oTfz
7GoVTMzxOriMVPa5o5wrHeSjqOl0X6fY60mbdb2Cv1sz7554laShR2JAdYh+TuyCsUDeo9ur
pihWoJpHg5YRH4CQokpxkWRNSEzAAVGc56qodhTUgVEodAhSHFQjytRpPGMIkRMBMOpGvWEU
3+9GiYzyID0/vP0Y/Xp3elIS/83r6Q694wm3lTqH9w6UsRauKmQTh2D7UJE+dIQUSygdWKqP
1Wt6tzfPd/+5eT4pqfD88P2RvGQ1hxsNyse3Z3UAsBTCYbqTam/EZhYtpGpZxRZKlbu9xRR/
xxVdKVFxxdEslkU+46gJxM1AY6rEUSGzpT+z4LZt0Qq8qqqGh9n+XWKjnXwrCnm72/W7C+v+
AZlAijqL1e6buFygtr9rAyvQ14xgjbKuM2sg6p01CluDNCE2DunRrN77DrjGPY3beto46axb
2FHedjGBwc2qhQPDJ+gWLO3xlDWdnJlI0lWBjafamPFNRmB4bFwJBrY/Zs6RkiKDb9U/rTHe
WeG8eL4daeKovPly0q/sbH8t5tdg2LCpqXNLTlEdEX9Hvog3w/lElR3m8m8z4KLag+b946ti
HI+3DtOuGMJH0JcvUsk0cNOVNVVLMMU83b9Y11OyCEe/yp8vr6f7UfEwCr+en/4FB8bb819q
EO0n6GpiJvm6EuF6Q6erDEvyWkhHjexjifQLRZsSNrJyetrQkazQ1Cwz2EvWVfyp60ObHG0e
VbseyBVES2o2xaGLe6XkVv0wEPEdlKmMK2C3gvi3IBnAhZoUhwEyPEqUpRj8tZAgffKWW0N6
6WQTH8j7TXWoDS9G4PGPV3Wg7/zFW8WYzHA91lAPfR2hSj4XubDxY+njRzotTF+ytqASvr1g
ikOZXQiTCTZ0vuDsMTQmLAIngb7baXH+fqSFq3qxnE/sXslsOsXWzC3c+Q3DWw4c0tC0bbk0
fmltvGKoSYu9Gya4lASMoMx5xIE12A87wLt1stZECrevcdXO4yrL/JO8S738xsoKvigqCXO8
z+LjLOrc6fzppQ3dZHz3FnuVCQ9f3K6y0JuOjX9eN0rFJUIhUh+yVTVUfODRPag7gjgmcoAG
tyHv0VWVnL47ymiJk+HHnTfGkQCzTMwDPNtbgHatA5nfFrEI8H2wApbTqddQobVFOYDbcAyD
MT60KGDmk/iV9W4xIYENFbAS0/+3TsBET1ZMKsWvauHKfkav9P2lx9Lk3nUezGn+Ocs/X5Kb
3Lk69ZH00qf0JY5eDubusHrFNPKp3sBwOIpFYgnzblMStF3oBAMJLTv6U4puE8W80GAn2XEe
0Szm9SPHQm/B9RrAVckbMQAm+LyehaU6px8pEOAHhlmcN589Xl12lE1aESgX+zl552EYKx8J
bXQsyyxpkgH8QPAaTCfC8cJzYFh9YTB1DJfkvYyG5WKGNyLAjPtHWpN5YQiuBCg6A5R147Ce
eWP6+0NSgltFuA0juHGP1xyxfun+6bsSg9hyWExmvf4m/Hq6194xpaV2qVM1quX2ElGrmyni
E13rh8+LZe+nY3u+6yz5QacYPt7fPz5cSkVM0fB56kuGkZ0MPpMXlcxFwyVl2dXL69T8Upb9
r0ylnKH2GUiMqpbX0grdNMImGa0dMKLyUmzrxjAwN9eajmdEpzOdzMY0TRWU08D3aDqYsTRR
Gk2nS79i5vEtyoAJA8a0XTM/qLgGckoeKKv0HHN2SM88lqaFctZK3Fl3XIh4D8hm/gSvVMWE
ph5lStMFHiLFg4I5vgYDYImZkll90cXkH6b03dv9/c/2FEInmXFGGR82cc5mgpHmmf6DU4zA
wuclztBLVboxa4jYcXq4/dmrXf8LKrcokn+UaUpvR/Sh8ub18fmP6Pzy+nz+8w2UzERLa15p
m+eaX29eTr+l6oenu1H6+Pg0+lWV+K/RX32NL6hGXMo6mFz253+u3KUzGSDyprmDZhzy6ZI4
VjKYEmFu482sNBfgNDYkum2uq8IluRncKZhp0rDcpskOsS2pNxP/YvCwPd18f/2K+HKHPr+O
qpvX0yh7fDi/0sFcx0FAjC80EJA1MBl7qJK3+/Pd+fWn48Nk/sRDayPa1vgqdhvBjSaO0Fnv
8dqSyZwId5D2+2oTNRlfwUHT/enm5e35dH96eB29qe5YMyMYW9MgoOJ6wr5w4vjCifWFd9kR
M6AkPzRZuZ+NlUhFz0WYQJg/IlicHxpKXZRglC3jAYMEEX1Uk3CCB12kisFhHwCijOSSuCfU
CIn2vtp6RNMeZhPfwzoNADDfVOkJllNVejbDovym9EWpvqYYj/H5D8wjPMxO8QEIv3pDeFnh
S7KPUng+FvirshoTt3Ldfmp5w6sr4j9OzfMgIBf2RQmGoihLqeryxxRTB4zJBL/cr0M5CbyA
AVjd3LVI24LMqC1IMMXKlL2cegsfcZJDmKe0kYc4U1LgvF8n2c2Xh9OrObM6ZshuscRaJbEb
L5d4vrRn00xscifoPMlqAj3yic2E+DNAHxByx3WRxRAtdkLdgE6mxMarZX+6fDdn7Nr0HtnB
OLtPsM3CKbmRYQTaXU5EdjHJw+3388PQsGMZNQ+VzO3oPcpjdElNVdRdIO5/YiEDXd5W7RW4
SwrWDo2rfVm7ycY3wIVE9uOnx1fFcM/WXUgEr23oqS3wJkxiInO6LlO1nfi93PB8egF+/u6g
8ZDuJamyTD287Zg0u5cwGJ2jZTqhP5RTojs0aVaQwWhBCpvMrbnHGo1R56HAUEjJ9ZTszdvS
H896wVJvAg9gHWYvczlZ6pN6O8SPP873zi07TSJRQcjhuDlgDnVcTi87fn26fwJJ0PmVsvS4
HM8Iv8vKMdYg12piYY6p05ip5fWKJJoyyTdlga1oAK0LHLhF54urNcsD9g3U6dghi9toweYR
aBaPVs/nuy+O62TIGoqlFx6xswhAawlurEkZj06P04csgfzzxXiKcw9dYEPePXG3BkiZFPiy
AuvOVIK7AgMoTEs597APCkBbRRsFtZ/WCcVAlwEvgymqnaFix6QA0tjCGmnfPhOFGBDqq9QC
aPiVpPoE2jC0H1VZs4GI0eLY5NUH7zJnlAg3bshL46SEoH0kFoa54qj1Aze0jfQxv4qwxoZE
asHFtX5HUhXUXmmNr8JVolmLXUyU0QAqXnmglkkKvKpgNcWgnsoo5aLQNstyez2Sb3++aD3U
ZUq0T6JppA0IBrIKsybXT8x9MmDgemI+BTwEKx/wbMl/2t7xZYmO1RHFBSV3Z2PQFJDYH0As
j6LxF3mmI7kMkGibtNPvdlQH2xKVvCXQv12RC12a/bttMlPCF33WDHinvGjb0CvdLnUFOiyH
Iju966B8R8//J/mm/tQuD7eoNmbbah8cw5jznlzogZPOfBeanyTbYDy3ew9RVlsrWjxVKjWW
kjiEBDi83uR7cHKc4OJB4Ueci2RYdZOZVz/9pD09g1MmbTh9b06T9pP0Ciut6u0+j+D2Mb0o
ViyLQmNBiKZ1a1K4SuC3auXi++RklR+iBAcW66I4l8QuMY+AQNJhKhKWA5v4kER+oKVBsl8q
fH0bKtw9F2FR48FUrDVek3BR+j7505oW0FsGsMymYHOrxIqWmLWrhG0sq817qtDhuBbRHJ6B
jSMQHDSkQ6iXhB7dOPNKJ6qWq6vc2lUu8bQCFolgrf/X+cubEkfgxYNl4AB5ENdVqSbbVNoh
UkczZZ3BRlyzXqpP9kn8oBZojqLG9lcdDNE/jo0IU5sk43BfEU/CijLhhU+GS5kMlhLwUoLh
UoJ3Solz/SSJxKLrfjJIYy4jPq4in6Z4DlVYtgpFuMWvlWJwJasoxKVpBzLT1R7Xrs2SfF04
C+LfCJMcY4PJ9vh8ZG376C7k4+CP+TBBRjjNQXgBVO6R1QPpT/sCM+6ju2qAsZh7tCvdrCWd
zS3QgIkXWHlHKWIgRcizd0hT+HhH6OHeFqRpBQ9HHui0VaSxVc6E3BHjc0zE7VjVfKp0iGtg
epqeRpqVbOj36XNU+1ztkrkiaiMrqwI2ngYUknpBzpOUD9zaZ+3VAAyFKxufuB3s6FtHsuec
ppgeu6pwLWdN0xozYs5jfqI9uyT5xzhkP4KQBUeSdjIeOIORhiRgM2bmHdoc1T4PEQ2uB+hD
LZd5USdr1P2IA4kB2OFqLXi+DmkdscOREsKAJ0TZx1akToI1rY5gqG9V1mQIdeyoNtuVqHLS
JwOzqWXAuoqxmLDO6ubgccBnvwpr/DpxXxdrSTcIkCcIEBIBozjEVSquTY725d/tV+zMbC0Z
+24Bvrg7eKu4XLGpRGaTrL3BwMUKJho86UQLS5NYsL8LZvkuulBw/aZD0W9K1vojOkR637e2
/UQWy9lsTDl+kSY4btvnhMWFj9YNT+dpP4ZRIf9Yi/qPvHZXuWa8IJPqFwQ58CyQ7nwuhUUU
l2ITfwgmcxc9KeCwCYHnfjm/PC4W0+Vv3i+ujPt6jcwP8poxLg2wkdZYddX1tHw5vd09jv5y
9VLv2OSuAoAdtQXQGITOwBNZg9DDJisUg8bGBJqkROU0qrDSdBdXOa6K3ZLUWWklXazLEBhL
3u43arWvcAEtpNuIZqH+HxtE7f1KT81rtUtiU/eiEvkmZtlF5AbMmHfYmmWKNZt0Q2BjLtm7
tC37vUqXahcfwJwbLW+4BvieyZtpCVZ88+yQtqSxhesLFm4seKGCOzLF0giXN1SpjkeismD7
c/e4U+TrJBuH3AckdbjTN7lqC2kjPVud+0z0fAZLPxccqqi/yhbcr3RI+/5eoq0VbJ+bvMhj
x6UEzlJCUGDTbGcR4MbNef+BM63FQZ0dVZNdkQNXCfvGHQKOZsDwODJj5MhABqFH6XAZWMDY
IDP4vplKoqRxJruVqfYDwh4+7YXcuhAji3Rb3sWIm5CjpFI7lsucu8sWxdBLNZ75JnUX1OYY
DvDozAkiCrjzfadqNp17nA5kD6efAydaONDjZwcY6NsXuISB2ePIEGermEZtv4xmJTZZrMSl
VqSAAib9HsjPR+BM90gPKRlnZCUDPuXHwIZmboixr8oq3iAQLQlMlq/7yHYXb90sQ1a743Na
BRX11uXaW2dTvIQF1SshWmrM0/ZFT4uXmdxY4JqJ/mp/OtCVy1eyWZCaA1OUB2s5Fpzxa4Rl
Iz1on6e5d8qcCyYqjUVhnZ7wNGXdGgtoWl7hm0+To/EsBKtj8o4HKKmZPGvXFP6ZAFPirTMv
PCfEJd3zdjTakguWh1YEN0nUREUm1Abwy7fT88Pp+++Pz19+sX6VJUr6pUemltZtWuATBxur
V0VRNzkfYEvwz82pv4vaE+XsB1xSXOMon5BS38z6JhH/cJHry0X800V6DBmkR5+PtabIUCZO
wjujoumDR+FNpT3EKFGjwEHXVAN40pp1qnN2dCQgcONWuc8r4o9Bp5sNViy3GHCS1l20RaOz
XCGqx1BIs6tWUys3+4otqt+s0wBXYVxu6cnSAGzWtKhLmgoT8vPEvjG6YD4Dr2Kxa8qrZitw
1FhN2pehSFk1fFfUmG4Sw6wGWkfNHuNNiobqltmK51UQsdQKE+eKC0vK90J9boFdo4Y3CvRu
wVCNqwDrMsUQZV0VNgpzL7eqKZTAZ6MyU/2LCgvPUwuKjzXRBaljq6BHG37UsUdbuIZlSUdF
J11ZXHPOEGzxnbY/ld0Z2XWEBnJ3Bm8CbPxBKPNhCrbCIpQFtrxjFH+QMlzaUAtISFRG8QYp
gy3AdmyMEgxSBluNH9kwynKAspwM/WY5OKLLyVB/lsFQPYs5608iC5gdzWLgB54/WL8isaEW
MkwSd/meG/bd8MQND7R96oZnbnjuhpcD7R5oijfQFo81Zlcki6ZyYHuKgdN/JS3jiOYdHMbq
4BS68LyO91XhoFSFkqCcZV1XSZq6StuI2I1Xcbyz4US1irzT7Qn5PqkH+uZsUr2vdiR0OhDo
zR5R9agE1azutDA5+npz++388KUzHH96Pj+8ftPBoO7uTy9f7BgD+qJ7x+JqmMsmuM1XB99D
nPZ8tHfQA55WsySkbQgf75/O30+/vZ7vT6Pbr6fbby+66luDP9u1t7E14IZdFVWqA7mo8Rmz
pWd7WXOdojp1ZuaXxLO92hyTEhwqqKMQPn1UsYjMY3WJhnGfK1k4gqyrAu8demkXVznx/WBp
tbaqTHitylpmMkojbMLVYSZIxBBOMd0vchy1SlQaV4dq08+y0EoKyfvf4lYrCzALMOIVj/yb
CTDPUsczbImFwP5i2Qz+h/EPjxYO17RaQv2fSyj4UXT68+3LFzP18CAq+QHcGWGJ2JQCVIi/
EA4Suq/fTT76dVTPZUFlJ4o3edGqBgdzfI4x47hUr2bLmuNGwSEHYIcfBUpfE8UQpWmD38GS
qcMXSqvCvZ6FQ3Rz0dR7Hh7Ixca5/9wy3XehacmJBmAm42/FoXNgtcviLFUzj9f2d3gTiyq9
Bp5jrpCC8XggI3XHxYh9wOq19QnBAcpOnX7Jfb8hHTIbUX8Ek0h7UrVygOVmnYqN9SFbh2pJ
nlizo12cavmV7sHUTQb93jotrpz9GSRujaml0WXB6hzB0663J8OTtzcPX7AVsTpq7Ev101rN
CKyqAf9h4NQu0+4B22ws7vZwnuYg0n38ATEQKL/ZgrVfLSSZC+az9SS9KuCs7/lju6JLtsG2
sCy8KVefLs75EX+AnHDtX5RyAOYFGWLX2r6txhcPP4hrkBrAaIwtJ5PPzNcYjN5cOwxUuYvj
kvDAzlOOKc5YmcNTwJ4/j359aT0qvfx7dP/2evpxUv84vd7+/vvvyLmTqaKq1d5bx8fYmtTg
Y4/ek7WT3Z396spQFPMorkqBrcpMBiirYftBWanJbZ+C9YVMXFJAd9lVKMlpYFEXILvINLZp
nWGNKJOep0tWlVogSl6LmVsffRML9s2MCeivyK5pW55lGPAArDYhxdCwnh/xBfXfASwypVXo
MIXq5lsGlDhhfNNsEG1jkTi2qbCKIyWDJ+KiOVe7klMe0J9TEfkXhl2sissYZD8sBMkSFOCa
bMk57m+gsyp++B78f40d2VLkNvBXKN6TZSZAyAMP8jXjjC98wAwvLsJOApUAWxwJ+/fpbll2
S2rDVlFFTXdblnX0IfWBPkPFkDlpOsoHCt6kdIwPJMirYT6zbNzvywXHO9OMoPjCL0Snt8TF
oKbVjoI2zCMtNVCf8GKG2xLDRGD6RwpG8k41ywRG8yNq1ljcotPtJ1TzrkQqzZpMBTZEq1DO
XiZErjaoW1101uwQKi3HIXWeycOZRxJkKLO9FPR1l2LamXgbYOdahbVYhLu2tCIbQCdfq2aU
vnUKuxTdk0DBqnaaSfuM8jMywrCu+KfKZaUXFndnQFaQdIX+kI+xq1pVa5nGmHHuNZJuQPcn
J+2RllQdOSTo80G7ASlpj3IHDXqjzvJqN68bdvLU1ch2XacACo4neksEhFg4BLaGLsbofRtr
itbhlXN87rVnIjbchgZCf07cAZudik9mAcQF6EyJB9cKgNfYsEL0qPtD3RSgR65LVyhNiFHh
tMcjqFUBwwjcmO6y0AeBM0cDV0WB8Yx42UkPxI0cZmHIYWFIhFwuep9o4gCYVyNvOIiHfAlC
g3OLeZyCoWP+gM4scTPcnmlnEK0CiVE5wmZaslqUzEwX5cDmk4A+byZ2051a2lp9ACxpnata
3jSfoeXe6n7GRZdjb5xqk6afeshNCjIt498e6Zin3b+8WlI+20Q8qIFGAFUMsA34BtrQZDbc
eZctgokZwti7wjxAJ0s3pyJqB5eUOdvgRgNxMIJtoNYBT4+F2dXFPLFA56k7WPgx63gbdby+
r57klsZ6HWeVPX2I3AC25THvBKWjt8QBBmlrrQqtseAFmZPtMejSDO+Sw6Z2Ksei6upoHHoW
Nvn0/QQZhZIDD6rEgSRpnV8pftevG4hiqxTpMBSqhW24iXeYC3tyhcHKLyInIFFC0nWzipgy
4f8ycYCh6yNBSEdXn2DkfGElwmY4RAzTd354uUgWR0eHFtnG6kUUfHBAhlj4bgpitJ9BiZUW
HXolgU3a1mW1BrN1tBa7oOHHwvQTGGi6KnIrtyLTQSiqKG20gLMcc7TGoSnYFinnMPrgRZ8E
c0sSePj6cgXG7siKddKl/e3bM8Yie8e5NOWTcg8bATY+ckNA4PhyT0OPvK0xAiFyoIPzuAeH
X3207kt4iXI89EZfgCiPGwoRpc/2CXxIIjXjJV12Mf02qXMBbdu5WZNjPrwKPaCwzl19fnpy
8sup9xQwJFgoW6G9ATOdcfwIjXtc4VFGaWNzFp8C7wC4JuxRqMvQPRH0aEjvBU0e0zwPnTqa
Ja7KLA13sG+wqlaqE2x+0LZEbj78N/+p3Mo0asNBZYGV2olfS3iYdNdaGClAqJS7chZB3cIw
hQqZR1vv7KsLibiL0hbPRM8XR8vjOUoQZS2L5cFaBmL3VAVLIi8/Qv3AwhlJbbeNyQUHXl+l
xTxmYJyRQLFTbjVzJ/JnBJHrhEKDXUKCDM/zGPe9wzcmEsZvassYYK3g6DOEXX5d9XmsGjwx
qEIwmqMtzBHH4oavOx38MEpBRLRxjknTJT9fROOx5UDhPtmkq8+eNsJpbOLw/uHmp8fJx4wT
4Qz2zZqqEVgvcgmWJ6eiri/Rnizk8GuP9qpySGcIzw9f7m4W1gfoEH297e05wYs+EQHLFnQ6
fixGczG7CgBpxJaOKdLeOoOrJ2hfIM972AUNnrVEllc6PhtkwCxI8RWbxq3Qb094hTQEI0TL
jcMv+9fbL3/vv798eUcgzOLPX/fPh9InmY7ZVwwxv9SAHz16T/VJ03U8ThsR5OQzsDfysWps
vNBZBM93dv/vg9VZM5uCkBuXh0+D/RFXkkeq+eCP0Rr29WPUkQolU9MhgxW6/wdLJYxfvEVW
igcc3DWKDAunzgPBQB0Lq50L3XJOrUHVhQvRdgqarladBSxUaBS28Pn7t9eng9un5/3B0/PB
3f6fbzyJ4VDVUGUrxTPXWOClD7euHRnQJwWbPkyrtVXawMH4Dzk+gRPQJ62to6ERJhL6t8mm
67M9UXO9r3m5sQGWq0KtBNoB7rduhzfa1EY3cy2bgWqVLJZneZd5iKLLZKD/+or+e2BUay+6
uIs9DP3zZz6fgauuXce8LpGpr6mtcZ1M4u31DlNTUYGRg/jxFtcr5gb47/717kC9vDzd3hMq
unm98dZtGOb+yAiwcK3gb3kEsmFnF84ZCJr4IvX2UB/DQ8BXx5wvAWXWfHj6yuMrzSsC/0PD
1p/eUJjMmAdoD7CMx4uNEya8ZCs0CGLnqqajhKGgysvdXLdz5Te5loBb6eWX+ZQqNbr/a//y
6r+hDn9ZCmODYAnaLo6iNPGnVWQKsxOaR8cCTKBLYY7jDP/7ezzH6ksimHtfTmDQlCSwVbDK
LLg1LwM1AaUmtF7lb6NVbVUkNdu30sSa/d9/u7OL4xhm7S8aVXRBKoDr0B9KEG9XSSpMiEF4
vvBmglUeZ1nqM89QoZ/X3ENN608dQv3BioQvS2RGt1mra0GQNSprlDBlhokIzCMWWonryjq+
GZmf/+3tVSkO5gCfhmV0tcO0e1Y63/Hrk8F2cLgJDwcbYGfH/uKxgskm2HqqyHLz+PXp4aB4
e/hj/2ySDEs9UUWT9mElyeeoDij9eydjRO6jMRILIIzEaRHhAX+nwopogJdc6WICuZc0IYOQ
uzBimzl1YaSQxmNEinoVmUu224jB+BICr0+ak0qE64JP0s5H7EXorxq6jMlXbRw6322b2H27
q2IRWXVBNtA0XWCTkQURxjVeP6PrZ083/jxSfBM2v47+qDJWH7HH/DhPm0NVrKO8KJYY22eZ
OEPMRfwnqRwvB39iCqz7vx51gkTyXLXuNPIyAjuerG98z+EtPPzyBZ8Ash7Mnp+/7R9G1V9H
vs1blj6+OT90n9YmGRsa73mPwrjN/cbPFLVpOt+ZIC0QP95FDHkp/3i+ef5+8Pz09nr/yDUG
bW1wKyRI2zrGYzfrsGI60p/wkk8FzQnPv2duYpu2LsAk6pO6zB0dmZNkcTGDxSKdXZvyazeD
StIiwhsNfd3i46swxSJX/BrGoHiW6KbNq94tGgjKC2ikaWsx/XBxalP4+g003Xa9/ZStG8FP
4bJqgMMOi4PdGZ8CC3MsWrsDiaqvnPMkhyKQC8TVIQsjyNLA1/JCXkmFjjKHgeQd1QhaLBgj
rUYiccEUUZmLIwGibIzct6E69tqGYyA1clRbUhLUk58gOIWWESq1DKJSpAYBKsPFVrbXCHZ/
91teYGGAUfq/yqdNFY/bGYCK31RMsHbd5YGHQAcsv90g/N2Dua7P5oP61XVaiYgAEEsRk13z
c1aG4JHrFn05A2efbzYwuSUpy8W1jtHXssxKS+3kUGz1bB7Fd3fAPf0DWtIF3vXiibp1LQwm
W4xrXoL1G/t+eYQHuQhOeExDYOcgsm7GuYBuyjAF9kt8uuaXuHi9COyP3xBqELrAOD4LeBNp
xZNS/irhaD6sOswWhm7Z5PhhYcBA4q1GF1wgZGVg/xL2fpHZkaHjNel4zU8bIqFgwjblpfGy
uuvdaNfsum+5Vxu6hXDbEC/vpgGuL9AEZV3Oq9RO0+APB+CTiH0AZsqs41XatPwcOSmLVvA9
Ki03KyI6ez/zIHxZEuj03aqri6Bf33kMF4Ewr2kmNKhgFAoBjgkd+uN34WVH3pcUQq8Auli+
8wIsBF4cvS8sedagQ2gmSqIGc6BSaulJqJgV0OCiVGkhPHaZ1m2nsvTaaIb/Az8El03AywIA

--vkogqOf2sHV7VnPd--
